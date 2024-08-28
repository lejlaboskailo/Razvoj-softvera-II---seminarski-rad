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
        public ERestoranContext Context { get; set; }
        protected IMapper _mapper;

        public KorisniciService(ERestoranContext context, IMapper mapper) : base(context, mapper)
        {
            Context = context;
            _mapper = mapper;
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
            var entity = await Context.Korisnicis.Include("KorisniciUloges.Uloga").FirstOrDefaultAsync(x => x.KorisnickoIme == username);

            if (entity == null)
            {
                //throw new Exception("Pogrešan username ili password");
                return null;
            }

            var hash = PasswordHelper.GenerateHash(entity.LozinkaSalt, password);

            if (hash != entity.LozinkaHash)
            {
                return null;
            }

            return _mapper.Map<Model.Korisnik>(entity);
        }


    }

}
