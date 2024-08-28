using AutoMapper;
using eRestoran.Services.Database;
using eRestoran.Services;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using eRestoran.Model.Requests;
using Microsoft.EntityFrameworkCore;

namespace eRestoran.Services
{
    public class UplataService : BaseCRUDService<Model.Uplata, Database.Uplatum, UplataSearchObject, UplataUpsertRequest, UplataUpsertRequest>, IUplataService
    {
        private readonly ERestoranContext _context;
        private readonly IMapper _mapper;



        public UplataService(ERestoranContext context, IMapper mapper) : base(context, mapper)
        {
            _context = context;
            _mapper = mapper;
        }

        public override IQueryable<Database.Uplatum> AddFilter(IQueryable<Database.Uplatum> query, UplataSearchObject? search = null)
        {
            var filteredQuery = base.AddFilter(query, search);

            // Ako je search.KorisnikId int?, konvertuj ga u string?
            var korisnikIdString = search?.KorisnikId.ToString();

            if (!string.IsNullOrWhiteSpace(korisnikIdString))
            {
                filteredQuery = filteredQuery.Where(x => x.KorisnikId.ToString() == korisnikIdString);
            }

            return filteredQuery;
        }





        public async Task<Model.Uplata> InsertAsync(UplataUpsertRequest request)
        {
            var uplata = new Uplatum()
            {
                Iznos = (decimal)request.Iznos,
                BrojTransakcije = request.BrojTransakcije,
                DatumTransakcije = DateTime.Parse(request.DatumTransakcije),
                KorisnikId = request.KorisnikId
            };



            await _context.Uplata.AddAsync(uplata);
            await _context.SaveChangesAsync();



            return _mapper.Map<Model.Uplata>(uplata);
        }
    }
}