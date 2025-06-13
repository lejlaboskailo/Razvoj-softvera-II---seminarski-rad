using AutoMapper;
using eRestoran.Model;
using eRestoran.Model.Requests;
using eRestoran.Services.Database;
using Microsoft.EntityFrameworkCore;
using Microsoft.VisualStudio.Services.Organization.Client;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.InteropServices;
using System.Security.Cryptography;
using System.Text;
using System.Threading.Tasks;

namespace eRestoran.Services
{
    public class KorisniciService : BaseCRUDService<Model.Korisnik, Database.Korisnici, KorisnikSearchRequests, KorisnikInsertRequest, KorisnikUpsertRequest>, IKorisniciService
    {
        public KorisniciService(ERestoranContext context, IMapper mapper) : base(context, mapper)
        {
            _context = context;
            _mapper = mapper;
        }
        public async Task BeforeInsert(Korisnici entity, KorisnikUpsertRequest insert)
        {
            entity.LozinkaSalt = GenerateSalt();
            entity.LozinkaHash = GenerateHash(entity.LozinkaSalt, insert.Lozinka);
        }
        public static string GenerateSalt()
        {
            RNGCryptoServiceProvider provider = new RNGCryptoServiceProvider();
            var byteArray = new byte[16];
            provider.GetBytes(byteArray);
            return Convert.ToBase64String(byteArray);
        }
        public static string GenerateHash(string salt, string password)
        {
            byte[] src = Convert.FromBase64String(salt);
            byte[] bytes = Encoding.Unicode.GetBytes(password);
            byte[] dst = new byte[src.Length + bytes.Length];

            System.Buffer.BlockCopy(src, 0, dst, 0, src.Length);
            System.Buffer.BlockCopy(bytes, 0, dst, src.Length, bytes.Length);

            HashAlgorithm algorithm = HashAlgorithm.Create("SHA1");
            byte[] inArray = algorithm.ComputeHash(dst);
            return Convert.ToBase64String(inArray);
        }

        public async Task<Model.Korisnik> InsertAsync(KorisnikUpsertRequest request)
        {
            var entity = _mapper.Map<Database.Korisnici>(request);

            entity.LozinkaSalt = PasswordHelper.GenerateSalt();
            entity.LozinkaHash = PasswordHelper.GenerateHash(entity.LozinkaSalt, request.Lozinka);

            await _context.Database.BeginTransactionAsync();

            _context.Korisnicis.Add(entity);
            await _context.SaveChangesAsync();
            await _context.Database.CommitTransactionAsync();

            return _mapper.Map<Model.Korisnik>(entity);


        }

        public override async Task<Model.Korisnik> Insert(KorisnikInsertRequest request)
        {
            var korisnik = await base.Insert(request); // Čekaj da se insert završi

            var uloga = _context.Uloges.FirstOrDefault(u => u.Naziv == "Korisnik");
            if (uloga == null)
            {
                uloga = new Database.Uloge
                {
                    Naziv = "Korisnik"
                };
                _context.Uloges.Add(uloga);
                await _context.SaveChangesAsync(); // async verzija
            }

            var korisnikUloga = new Database.KorisniciUloge
            {
                KorisnikId = korisnik.Id,  // Sada je ID sigurno generisan
                UlogaId = uloga.Id,
                DatumIzmjene = DateTime.Now
            };

            _context.KorisniciUloges.Add(korisnikUloga);
            await _context.SaveChangesAsync(); // async verzija

            return korisnik;
        }

        /* public async Task<Model.Korisnik> Insert(KorisnikUpsertRequest insert)
         {
             var set = _context.Set<Korisnici>();

             Korisnici entity = _mapper.Map<Korisnici>(insert);

             set.Add(entity);

             await BeforeInsert(entity, insert);

             var uloga = await _context.Uloges.FirstOrDefaultAsync(u => u.Id == 2);
             if (uloga == null)
             {
                 throw new Exception("Uloga sa ID-jem 2 nije pronađena.");
             }

             var korisnikUloga = new Database.KorisniciUloge
             {
                 KorisnikId = entity.Id,
                 UlogaId = uloga.Id
             };

             _context.KorisniciUloges.Add(korisnikUloga);

             await _context.SaveChangesAsync();

             return _mapper.Map<Model.Korisnik>(entity);
         }*/

        public override IQueryable<Korisnici> AddInclude(IQueryable<Korisnici> query, KorisnikSearchRequests? search = null)
        {
            if (search?.IsUlogeIncluded == true)
            {
                query = query.Include("KorisniciUloges.Uloga");
            }
            return base.AddInclude(query, search);
        }

        public async Task<Model.Korisnik> Login(string username, string password)
        {
            var entity = await _context.Korisnicis.Include(x=>x.KorisniciUloges).ThenInclude(y=>y.Uloga).FirstOrDefaultAsync(x => x.KorisnickoIme == username);

            if (entity == null)
            {
                return null;
            }

            var hash = GenerateHash(entity.LozinkaSalt, password);

            if (hash != entity.LozinkaHash)
            {
                return null;
            }

            return _mapper.Map<Model.Korisnik>(entity);
        }

        public async Task<Model.Korisnik> Register(string username, string password, string ime, string prezime)
        {
            if (string.IsNullOrEmpty(username) || string.IsNullOrEmpty(password) || string.IsNullOrEmpty(ime) || string.IsNullOrEmpty(prezime))
            {
                throw new ArgumentException("Svi podaci moraju biti popunjeni.");
            }

            var existingUser = await _context.Korisnicis.FirstOrDefaultAsync(x => x.KorisnickoIme == username);
            if (existingUser != null)
            {
                throw new Exception("Korisničko ime već postoji.");
            }

            var salt = GenerateSalt();
            if (string.IsNullOrEmpty(salt))
            {
                throw new Exception("Greška pri generisanju salt-a.");
            }

            var hash = GenerateHash(salt, password);
            if (string.IsNullOrEmpty(hash))
            {
                throw new Exception("Greška pri generisanju hash-a.");
            }
            var defaultRole = await _context.Uloges.FirstOrDefaultAsync(u => u.Naziv == "Korisnik");
            if (defaultRole == null)
            {
                throw new Exception("Podrazumevana uloga nije pronađena.");
            }


            var newUser = new Korisnik
            {
                KorisnickoIme = username,
                LozinkaSalt = salt,
                LozinkaHash = hash,
                Ime = ime,
                Prezime = prezime,
            };

            var newUserEntity = _mapper.Map<Database.Korisnici>(newUser);
            _context.Korisnicis.Add(newUserEntity);

            var korisniciUloga = new Model.KorisniciUloge
            {
                KorisnikId = newUserEntity.Id,  
                UlogaId = defaultRole.Id       
            };

            try
            {
                await _context.SaveChangesAsync();
            }
            catch (Exception ex)
            {
                throw new Exception("Greška prilikom dodavanja korisnika u bazu podataka.", ex);
            }

            return _mapper.Map<Model.Korisnik>(newUser);
        }



    }

}
