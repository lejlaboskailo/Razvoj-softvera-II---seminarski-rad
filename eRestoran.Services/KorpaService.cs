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
    public class KorpaService : BaseCRUDService<Model.Korpa, Database.Korpa, BaseSearchObject, KorpaInsertRequest, KorpaUpdateRequest>, IKorpaService
    {
        public KorpaService(ERestoranContext context, IMapper mapper) : base(context, mapper)
        {
            _context = context;
            _mapper = mapper;
        }
    }
}
