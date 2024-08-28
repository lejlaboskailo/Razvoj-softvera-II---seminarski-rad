using AutoMapper;
using eRestoran.Services.Database;
using Microsoft.VisualStudio.Services.Users;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.InteropServices;
using System.Text;
using System.Threading.Tasks;

namespace eRestoran.Services.OrderStateMachine
{
    public class AcceptedOrderState : BaseState
    {
        public AcceptedOrderState(IServiceProvider serviceProvider, IMapper mapper, ERestoranContext context) : base(serviceProvider, mapper, context)
        {

        }
        public override async Task<Model.Narudzba> InProgress(int id)
        {
            var entity = await _context.Narudzbas.FindAsync(id);
            if (entity == null)
            {
                throw new UserException($"Order {id} does not exist");
            }
            entity.StateMachine = "InProgress";
            await _context.SaveChangesAsync();

            return _mapper.Map<Model.Narudzba>(entity);
        }
        public override async Task<List<string>> AllowedActions()
        {
            var list = await base.AllowedActions();

            list.Add("InProgress");

            return list;
        }
    }
}
