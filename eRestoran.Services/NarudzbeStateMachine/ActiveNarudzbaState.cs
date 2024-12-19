using AutoMapper;
using eRestoran.Services.Database;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.DependencyInjection;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eRestoran.Services.NarudzbeStateMachine
{
    public class ActiveNarudzbaState : BaseNarudzbaState
    {
        public ActiveNarudzbaState(ERestoranContext context, IMapper mapper, IServiceProvider serviceProvider) : base(context, mapper, serviceProvider)
        {
        }

        public override async Task<Model.Narudzba> Hide(int id)
        {
            var set = _context.Set<Database.Narudzba>();
            var entity = await set.FindAsync(id);

            entity.StateMachine = "draft";

            await _context.SaveChangesAsync();
            return _mapper.Map<Model.Narudzba>(entity);
        }

        public override async Task<List<string>> AllowedActions()
        {
            var list = await base.AllowedActions();
            list.Add("Hide");

            return list;
        }
    }
}
