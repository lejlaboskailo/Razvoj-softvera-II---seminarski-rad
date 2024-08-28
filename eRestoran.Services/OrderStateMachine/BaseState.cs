using AutoMapper;
using eRestoran.Model.Requests;
using eRestoran.Services.Database;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.VisualStudio.Services.Users;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.InteropServices;
using System.Text;
using System.Threading.Tasks;

namespace eRestoran.Services.OrderStateMachine
{
    public class BaseState
    {
        protected ERestoranContext _context;
        protected IMapper _mapper;
        protected IServiceProvider _serviceProvider;

        public BaseState(IServiceProvider serviceProvider,IMapper mapper,ERestoranContext eRestoranContext)
        {
            _context = eRestoranContext;
            _mapper = mapper;
            _serviceProvider = serviceProvider;
        }

        public virtual Task<Model.Narudzba> Insert(NarudzbaUpsertRequest request)
        {
            throw new UserException("Not allowed");
        }
        public virtual Task<Model.Narudzba> Update(int id, NarudzbaUpsertRequest request)
        {
            throw new UserException("Not allowed");
        }

        public virtual Task<Model.Narudzba> Accept(int id)
        {
            throw new UserException("Not allowed");
        }

        public virtual Task<Model.Narudzba> InProgress(int id)
        {
            throw new UserException("Not allowed");
        }
        public virtual Task<Model.Narudzba> Finish(int id)
        {
            throw new UserException("Not allowed");
        }
        public virtual Task<Model.Narudzba> Deliver(int id)
        {
            throw new UserException("Not allowed");
        }
        public virtual Task<Model.Narudzba> Cancel(int id)
        {
            throw new UserException("Not allowed");
        }

        public BaseState CreateState(string stateName)
        {
            switch (stateName)
            {
                case "Initial":
                case null:
                    return _serviceProvider.GetService<InitialOrderState>();
                case "Accepted":
                    return _serviceProvider.GetService<AcceptedOrderState>();
                case "InProgress":
                    return _serviceProvider.GetService<InProgressOrderState>();
                case "Finished":
                    return _serviceProvider.GetService<FinishedOrderState>();
                case "Delivered":
                    return _serviceProvider.GetService<DeliveredOrderState>();
                case "Canceled":
                    return _serviceProvider.GetService<CanceledOrderState>();
                default:
                    throw new UserException("Not allowed");
            }
        }
        public virtual async Task<List<string>> AllowedActions()
        {
            return new List<string>();
        }
    }
}
