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
    public class GradService : BaseService<Model.Grad, Database.Grad, GradSearchObject>, IGradService
    {
        
   
        public GradService(ERestoranContext context, IMapper mapper)
            : base(context, mapper)
        {

        }


        public override IQueryable<Database.Grad> AddFilter(IQueryable<Database.Grad> query, GradSearchObject? search = null)
        {
            if (!string.IsNullOrWhiteSpace(search?.Naziv))
            {
                query = query.Where(x => x.Naziv.StartsWith(search.Naziv));
            }
            return base.AddFilter(query, search);
        }


    

}
}
