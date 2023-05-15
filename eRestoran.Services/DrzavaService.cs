using AutoMapper;
using eRestoran.Model;
using eRestoran.Model.Requests;
using eRestoran.Model.SearchObjects;
using eRestoran.Services.Database;
using System;
using System.Collections.Generic;
using System.Diagnostics.Metrics;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Drzava = eRestoran.Services.Database.Drzava;

namespace eRestoran.Services
{
    public class DrzavaService : BaseCRUDService<Model.Drzava, Database.Drzava, DrzavaSearchObject, DrzavaUpsertRequest, DrzavaUpsertRequest>, IDrzavaService
    {
        public DrzavaService(ERestoranContext context, IMapper mapper) : base(context, mapper)
        {
        }
        public override IQueryable<Drzava> AddFilter(IQueryable<Drzava> query, DrzavaSearchObject search = null)
        {
            var filter = base.AddFilter(query, search);

            if (!string.IsNullOrWhiteSpace(search?.Naziv))
            {
                filter = filter.Where(w => w.Naziv.Contains(search.Naziv));
            }

            return filter;
        }

    }
}
