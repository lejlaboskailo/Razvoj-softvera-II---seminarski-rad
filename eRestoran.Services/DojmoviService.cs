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
    public class DojmoviService : BaseCRUDService<Model.Dojmovi, Database.Dojmovi, DojmoviSearchObject,DojmoviInsertRequest, DojmoviUpsertRequest>, IDojmoviService
    {
        public DojmoviService(ERestoranContext context, IMapper mapper) : base(context, mapper)
        {
        }

    }
}
