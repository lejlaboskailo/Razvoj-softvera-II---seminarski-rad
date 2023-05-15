using AutoMapper;
using eRestoran.Model.Requests;
using eRestoran.Services.Database;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.InteropServices;
using System.Text;
using System.Threading.Tasks;

namespace eRestoran.Services
{
    public class KorisniciService : BaseCRUDService<Model.Korisnik, Database.Korisnici,KorisnikSearchRequests, KorisnikUpsertRequest, KorisnikUpsertRequest>, IKorisniciService
    {
        public ERestoranContext Context { get; set; }
        protected IMapper _mapper;

        public KorisniciService(ERestoranContext context, IMapper mapper) : base(context, mapper)
        {
            Context = context;
            _mapper = mapper;
        }

        public override IList<Model.Korisnik> Get(KorisnikSearchRequests search)
        {
            var query = Context.Korisnicis.AsQueryable();

            if (!string.IsNullOrWhiteSpace(search?.ImePrezime))
            {
                query = query.Where(x => x.Ime.ToLower().Contains(search.ImePrezime) || x.Prezime.ToLower().Contains(search.ImePrezime));
            }

            var list = query.ToList();


            return _mapper.Map<List<Model.Korisnik>>(list);
        }

        public IList<Model.Korisnik> GetAll()
        {
            var db = Context.Korisnicis.ToList();

            var result = _mapper.Map<IList<Model.Korisnik>>(db);

            return result;
        }

        public Model.Korisnik GetById(int id)
        {
            var entity = Context.Korisnicis.FirstOrDefault(x => x.Id == id); 
            if (entity == null)
            { // Handle the case when no entity is found with the given Id
               return null;
              } 
            // Map the retrieved entity to the corresponding Model.Korisnik object
            var korisnikModel = _mapper.Map<Model.Korisnik>(entity); 
            
            return korisnikModel; 
        
        }

                public async Task<Model.Korisnik> InsertAsync(KorisnikUpsertRequest request)
        {
            var entity = _mapper.Map<Database.Korisnici>(request);

            entity.LozinkaSalt = PasswordHelper.GenerateSalt();
            entity.LozinkaHash = PasswordHelper.GenerateHash(entity.LozinkaSalt, request.Lozinka);

            await Context.Database.BeginTransactionAsync();

            Context.Korisnicis.Add(entity);
            await Context.SaveChangesAsync();
            await Context.Database.CommitTransactionAsync();

            return _mapper.Map<Model.Korisnik>(entity);

        }

        public async Task<Model.Korisnik> UpdateAsync(int id, KorisnikUpsertRequest request)
        {
            var entity = Context.Korisnicis.Find(id);

            await Context.Database.BeginTransactionAsync();
            _mapper.Map(request, entity);
            await Context.SaveChangesAsync();

           

            await Context.Database.CommitTransactionAsync();

            return _mapper.Map<Model.Korisnik>(entity);
        }
        public async Task<Model.Korisnik> Login(string username, string password)
        {
            var entity = await Context.Korisnicis.FirstOrDefaultAsync(x => x.KorisnickoIme == username);

            if (entity == null)
            {
                throw new Exception("Pogrešan username ili password");
            }

            var hash = PasswordHelper.GenerateHash(entity.LozinkaSalt, password);

            if (hash != entity.LozinkaHash)
            {
                throw new Exception("Pogrešan username ili password");
            }

            return _mapper.Map<Model.Korisnik>(entity);
        }
    }
}
