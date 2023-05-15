using AutoMapper;
using eRestoran.Model.SearchObjects;
using eRestoran.Services.Database;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eRestoran.Services
{
    public class UlogeService:BaseService<Model.Uloge,Database.Uloge,UlogeSearchObject>,IUlogeService
    {
        public UlogeService(ERestoranContext context, IMapper mapper):base(context,mapper)
        {
        }
        
        public override IQueryable<Uloge>AddFilter(IQueryable<Uloge>query,UlogeSearchObject search=null)
        {
            var filter = base.AddFilter(query, search);
            if(!string.IsNullOrWhiteSpace(search?.Naziv))
            {
                filter = filter.Where(w => w.Naziv.Contains(search.Naziv));
            }
            return filter;
        }
    }
}
