using AutoMapper;
using eRestoran.Model.Requests;
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
    public class KorpaService : BaseCRUDService<Model.Korpa, Database.Korpa, KorpaSearchObject, KorpaInsertRequest, KorpaUpdateRequest>, IKorpaService
    {
        public KorpaService(ERestoranContext context, IMapper mapper) : base(context, mapper)
        {
            _context = context;
            _mapper = mapper;
        }
        public  IQueryable<Korpa> AddInclude(IQueryable<Korpa> query, KorpaSearchObject? search = null)
        {
            if (search?.IsJeloIncluded == true)
            {
                query = query.Include("Korpas.Jelo");
            }
            return base.AddInclude(query, search);
        }
    }
}
