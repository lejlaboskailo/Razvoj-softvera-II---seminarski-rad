using AutoMapper;
using eRestoran.Model.Requests;
using eRestoran.Services.Database;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eRestoran.Services
{
    public class KategorijaService : BaseCRUDService<Model.Kategorija, Database.Kategorija, KategorijaSearchRequest, KategorijaUpsertRequest, KategorijaUpsertRequest>,IKategorijaService
    {
        private readonly ERestoranContext _context;
        private readonly IMapper _mapper;

        public KategorijaService(ERestoranContext context, IMapper mapper) : base(context, mapper)
        {
            _context = context;
            _mapper = mapper;
        }

        public override IEnumerable<Model.Kategorija> Get(KategorijaSearchRequest request)
        {
            var query = _context.Kategorijas.AsQueryable();

            if (!string.IsNullOrWhiteSpace(request.Naziv))
            {
                query = query.Where(x => x.Naziv.Contains(request.Naziv));
            }

            var list = query.ToList();

            return _mapper.Map<IEnumerable<Model.Kategorija>>(list);
        }
    }
}
