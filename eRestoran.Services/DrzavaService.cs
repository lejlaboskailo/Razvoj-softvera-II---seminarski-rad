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
    public class DrzavaService : BaseService<Model.Drzava, Database.Drzava, DrzavaSearchObject>, IDrzavaService
    {


        public DrzavaService(ERestoranContext context, IMapper mapper)
            : base(context, mapper)
        {

        }


        public override IQueryable<Database.Drzava> AddFilter(IQueryable<Database.Drzava> query, DrzavaSearchObject? search = null)
        {
            if (!string.IsNullOrWhiteSpace(search?.Naziv))
            {
                query = query.Where(x => x.Naziv.StartsWith(search.Naziv));
            }
            return base.AddFilter(query, search);
        }




    }
}
