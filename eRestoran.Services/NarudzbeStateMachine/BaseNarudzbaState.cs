/*using AutoMapper;
using eRestoran.Model;
using eRestoran.Model.Requests;
using eRestoran.Services.Database;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.VisualStudio.Services.Users;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eRestoran.Services.NarudzbeStateMachine
{
    public class BaseNarudzbaState
    {
        public ERestoranContext _context { get; set; }
        public IMapper _mapper { get; set; }
        private readonly IServiceProvider _serviceProvider;

        public BaseNarudzbaState(ERestoranContext context, IMapper mapper, IServiceProvider serviceProvider)
        {
            _context = context;
            _mapper = mapper;
            _serviceProvider = serviceProvider;
        }
        public virtual Task<Model.Narudzba> Insert(NarudzbaInsertRequest request)
        {
            throw new UserException("Not allowed");
        }

        public virtual Task<Model.Narudzba> Update(int id, NarudzbaUpdateRequest request)
        {
            throw new UserException("Not allowed");
        }

        public virtual Task<Model.Narudzba> Activate(int id)
        {
            throw new UserException("Not allowed");
        }

        public virtual Task<Model.Narudzba> Hide(int id)
        {
            throw new UserException("Not allowed");
        }

        public virtual Task<Model.Narudzba> Delete(int id)
        {
            throw new UserException("Not allowed");
        }
        public BaseNarudzbaState CreateState(string stateName)
        {
            switch(stateName)
        {
            case "initial":
                    return (BaseNarudzbaState)_serviceProvider.GetService(typeof(InitialNarudzbaState));
                case "draft":
                    return (BaseNarudzbaState)_serviceProvider.GetService(typeof(DraftNarudzbeState));
                case "active":
                    return (BaseNarudzbaState)_serviceProvider.GetService(typeof(ActiveNarudzbaState));
                default:
                    throw new Exception("State not recognized");
                }

            }
        public virtual async Task<List<string>> AllowedActions()
        {
            return new List<string>();
        }
    }
}
*/
using AutoMapper;
using eRestoran.Model;
using eRestoran.Model.Requests;
using eRestoran.Services.Database;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.VisualStudio.Services.Users;
using System;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace eRestoran.Services.NarudzbeStateMachine
{
    public class BaseNarudzbaState
    {
        public ERestoranContext _context { get; set; }
        public IMapper _mapper { get; set; }
        private readonly IServiceProvider _serviceProvider;

        public BaseNarudzbaState(ERestoranContext context, IMapper mapper, IServiceProvider serviceProvider)
        {
            _context = context;
            _mapper = mapper;
            _serviceProvider = serviceProvider;
        }

        public virtual Task<Model.Narudzba> Insert(NarudzbaInsertRequest request)
        {
            throw new UserException("Not allowed");
        }

        public virtual Task<Model.Narudzba> Update(int id, NarudzbaUpdateRequest request)
        {
            throw new UserException("Not allowed");
        }

        public virtual Task<Model.Narudzba> Activate(int id)
        {
            throw new UserException("Not allowed");
        }

        public virtual Task<Model.Narudzba> Hide(int id)
        {
            throw new UserException("Not allowed");
        }

        public virtual Task<Model.Narudzba> Delete(int id)
        {
            throw new UserException("Not allowed");
        }

        public BaseNarudzbaState CreateState(string stateName)
        {
            Console.WriteLine($"Attempting to create state with name: {stateName}");

            switch (stateName.ToLower()) // Koristimo .ToLower() kako bi upoređivanje bilo case-insensitive
            {
                case "initial":
                    return (BaseNarudzbaState)_serviceProvider.GetService(typeof(InitialNarudzbaState));
                case "draft":
                    return (BaseNarudzbaState)_serviceProvider.GetService(typeof(DraftNarudzbeState));
                case "active":
                    return (BaseNarudzbaState)_serviceProvider.GetService(typeof(ActiveNarudzbaState));
                default:
                    throw new Exception("State not recognized");
            }
        }

        public virtual async Task<List<string>> AllowedActions()
        {
            return new List<string>();
        }
    }
}
