using AutoMapper;
using eRestoran.Model;
using eRestoran.Model.Requests;
using eRestoran.Services.Database;
using eRestoran.Services.NarudzbeStateMachine;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.DependencyInjection;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eRestoran.Services.NarudzbeStateMachine
{
    public class InitialNarudzbaState : BaseNarudzbaState
    {
        public InitialNarudzbaState(ERestoranContext context, IMapper mapper, IServiceProvider serviceProvider) : base(context, mapper, serviceProvider)
        {
        }

        public override async Task<Model.Narudzba> Insert(NarudzbaInsertRequest request)
        {
            //TODO: EF CALL
            var set = _context.Set<Database.Narudzba>();

            var entity = _mapper.Map<Database.Narudzba>(request);
            entity.StateMachine = "draft";

            set.Add(entity);

            await _context.SaveChangesAsync();
            return _mapper.Map<Model.Narudzba>(entity);
        }

        public override async Task<List<string>> AllowedActions()
        {
            var list = await base.AllowedActions();

            list.Add("Insert");

            return list;
        }
    }
}

