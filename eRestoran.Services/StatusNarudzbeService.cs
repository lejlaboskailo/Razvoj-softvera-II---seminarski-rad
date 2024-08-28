using AutoMapper;
using eRestoran.Model;
using eRestoran.Model.SearchObjects;
using eRestoran.Services.Database;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eRestoran.Services
{
    public class StatusNarudzbeService:BaseService<Model.StatusNarudzbe,Database.Status,StatusNarudzbeSearchObject>,IStatusNarudzbeService
    {
        private readonly ERestoranContext _context;
        private readonly IMapper _mapper;

        public StatusNarudzbeService(ERestoranContext context, IMapper mapper) : base(context, mapper)
        {
            _context = context;
            _mapper = mapper;
        }

        public override IQueryable<Database.Status> AddFilter(IQueryable<Database.Status> query, StatusNarudzbeSearchObject? search = null)
        {
            var filteredQuery = base.AddFilter(query, search);

            if (!string.IsNullOrWhiteSpace(search?.Naziv))
            {
                filteredQuery = filteredQuery.Where(x => x.Naziv == search.Naziv);
            }

            return filteredQuery;
        }

    }
}
