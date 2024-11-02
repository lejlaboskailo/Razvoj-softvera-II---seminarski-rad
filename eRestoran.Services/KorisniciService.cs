using AutoMapper;
using eRestoran.Model;
using eRestoran.Model.Requests;
using eRestoran.Services.Database;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.InteropServices;
using System.Security.Cryptography;
using System.Text;
using System.Threading.Tasks;

namespace eRestoran.Services
{
    public class KorisniciService : BaseCRUDService<Model.Korisnik, Database.Korisnici, KorisnikSearchRequests, KorisnikUpsertRequest, KorisnikUpsertRequest>, IKorisniciService
    {
        public KorisniciService(ERestoranContext context, IMapper mapper) : base(context, mapper)
        {
            _context = context;
            _mapper = mapper;
        }
        public override async Task BeforeInsert(Korisnici entity, KorisnikUpsertRequest insert)
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


    }

}
