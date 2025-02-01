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
    public class RestoranService : BaseService<Model.Restoran, Database.Restoran, BaseSearchObject>, IRestoranService
    {
        public RestoranService(ERestoranContext context, IMapper mapper)
            : base(context, mapper)
        {

        }


    }
}
