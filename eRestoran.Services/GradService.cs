using AutoMapper;
using eRestoran.Model.Requests;
using eRestoran.Model.SearchObjects;
using eRestoran.Services.Database;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eRestoran.Services
{
    public class GradService : BaseCRUDService<Model.Grad, Database.Grad, GradSearchObject, GradUpsertRequest, GradUpsertRequest>, IGradService
    {
        public GradService(ERestoranContext context, IMapper mapper) : base(context, mapper)
        {
        }

        public override IQueryable<Grad> AddFilter(IQueryable<Grad> query,GradSearchObject search = null)
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
