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
    public class KorisniciUlogaService : BaseCRUDService<Model.KorisniciUloge, Database.KorisniciUloge, KorisniciUlogaSearchRequest, KorisniciUlogeInsertRequest, KorisniciUlogeUpdateRequest>, IKorisniciUloga
    {
        public KorisniciUlogaService(ERestoranContext context, IMapper mapper) : base(context, mapper)
        {
            _context = _context;
            _mapper = _mapper;
        }

    }
}
