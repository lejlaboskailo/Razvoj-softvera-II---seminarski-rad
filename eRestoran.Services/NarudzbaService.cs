using AutoMapper;
using eRestoran.Model.Requests;
using eRestoran.Model.SearchObjects;
using eRestoran.Services.Database;
using eRestoran.Services.OrderStateMachine;
using Microsoft.EntityFrameworkCore;
using Microsoft.VisualStudio.Services.Users;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.InteropServices;
using System.Text;
using System.Threading.Tasks;

namespace eRestoran.Services
{
    public class NarudzbaService:BaseCRUDService<Model.Narudzba,Narudzba,NarudzbaSearchObject,NarudzbaUpsertRequest,NarudzbaUpsertRequest>, INarudzbaService
    {
        public BaseState _baseState { get; set; }

        private readonly ERestoranContext _context;
        private readonly IMapper _mapper;

        public NarudzbaService(BaseState baseState,ERestoranContext context, IMapper mapper):base(context,mapper)
        {
            _context = context;
            _mapper = mapper;
            _baseState= baseState;
        }

        public Task<Model.Narudzba> Insert(NarudzbaUpsertRequest insert)
        {
            var state = _baseState.CreateState("Initial");

            return state.Insert(insert);
        }
        public async Task<List<string>> AllowedActions(int id)
        {
            var entity = await _context.Narudzbas.FindAsync(id);
            var state = _baseState.CreateState(entity?.StateMachine ?? "Initial");
            return await state.AllowedActions();
        }

        public async Task<Model.Narudzba> Cancel(int id)
        {
            var entity = await _context.Narudzbas.FindAsync(id);
            if (entity == null)
            {
                throw new UserException($"Order {id} does not exist");
            }
            var state = _baseState.CreateState(entity.StateMachine);

            return await state.Cancel(id);
        }
        public async Task<Model.Narudzba> Accept(int id)
        {
            var entity = await _context.Narudzbas.FindAsync(id);
            if (entity == null)
            {
                throw new UserException($"Order {id} does not exist");
            }
            var state = _baseState.CreateState(entity.StateMachine);

            return await state.Accept(id);
        }
        public async Task<Model.Narudzba> InProgress(int id)
        {
            var entity = await _context.Narudzbas.FindAsync(id);
            if (entity == null)
            {
                throw new UserException($"Order {id} does not exist");
            }
            var state = _baseState.CreateState(entity.StateMachine);

            return await state.InProgress(id);
        }
        public async Task<Model.Narudzba> Finish(int id)
        {
            var entity = await _context.Narudzbas.FindAsync(id);
            if (entity == null)
            {
                throw new UserException($"Order {id} does not exist");
            }
            var state = _baseState.CreateState(entity.StateMachine);

            return await state.Finish(id);
        }
        public async Task<Model.Narudzba> Deliver(int id)
        {
            var entity = await _context.Narudzbas.FindAsync(id);
            if (entity == null)
            {
                throw new UserException($"Order {id} does not exist");
            }
            var state = _baseState.CreateState(entity.StateMachine);

            return await state.Deliver(id);
        }

        /*  public override Model.Narudzba GetById(int id)
          {
              var result=_context.Narudzbas.Include(x=>x.Korisnik)
                                             .Include(x=>x.StatusNarudzbe)
                                             .FirstOrDefault(x=>x.Id==id);
              return _mapper.Map<Model.Narudzba>(result);
          }
        */
        public override IQueryable<Database.Narudzba> AddFilter(IQueryable<Database.Narudzba> query, NarudzbaSearchObject? search = null)
        {
            var filteredQuery = base.AddFilter(query, search);
            if (search.Id != 0)
            {
                query = query.Where(x => x.Id == search.Id);
            }
            if (!string.IsNullOrWhiteSpace(search?.DatumNarudzbe.ToString()))
            {
                filteredQuery = filteredQuery.Where(x => x.DatumNarudzbe == search.DatumNarudzbe);
            }

            return filteredQuery;
        }
      /*  public override List<Database.Narudzba> Get(NarudzbaSearchObject search)
        {
            var query = _context.Narudzbas.AsQueryable();
            if (search.Id != 0)
            {
                query = query.Where(x => x.Id == search.Id);
            }
            if (search.DatumNarudzbe != null)
            {
                query = query.Where(x => x.DatumNarudzbe == search.DatumNarudzbe);
            }

            if (search.StatusNarudzbeId != 0)
            {
                query = query.Where(x => x.StatusNarudzbeId == StatusNarudzbeId);
            }

            if (search.KorisnikId != 0)
            {
                query = query.Where(x => x.KorisnikId == search.KorisnikId);
            }

            var list = query.Include(x => x.Korisnik)
                            .Include(x => x.StatusNarudzbe)
                            .ToList();

            return _mapper.Map<List<Model.Narudzba>>(list);
        }
      */
        public async Task<Model.Narudzba> UpdateAsync(int id, NarudzbaUpsertRequest request)
        {
            var entity = _context.Narudzbas.Find(id);
            entity.StatusNarudzbeId = request.StatusNarudzbeId;

            await _context.SaveChangesAsync();
            return _mapper.Map<Model.Narudzba>(entity);
        }
    }
}
