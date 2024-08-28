using AutoMapper;
using eRestoran.Services;
using eRestoran.Services.Database;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using eRestoran.Model.SearchObjects;

namespace eRestoran.Services
{
    public class JeloService : BaseCRUDService<Model.Jelo, Database.Jelo, JeloSearchObject, JeloUpsertRequest, JeloUpsertRequest>, IJeloService
    {
        private readonly ERestoranContext context;
        private readonly IMapper mapper;



        public JeloService(ERestoranContext _context, IMapper _mapper) : base(_context, _mapper)
        {
            context = _context;
            mapper = _mapper;
        }



        public List<Model.Jelo> GetPreporucenaJela(int korisnikId)
        {
            var korisnici = context.Korisnicis.Where(e => e.Id != korisnikId).ToList();
            Dictionary<Database.Korisnici, List<Database.Dojmovi>> dojmovi = new Dictionary<Database.Korisnici, List<Database.Dojmovi>>();
            foreach (var korisnik in korisnici)
            {
                var ocjene = context.Dojmovis
                    .Where(e => e.KorisnikId == korisnik.Id)
                    .ToList();
                dojmovi.Add(korisnik, ocjene);
            }
            var dojmoviKorisnik = context.Dojmovis.Where(e => e.KorisnikId == korisnikId).ToList();

            if (dojmoviKorisnik == null || dojmoviKorisnik.Count == 0)
                return null;

            List<Database.Dojmovi> zajednickeOcjeneKorisnik = new List<Database.Dojmovi>();
            List<Database.Dojmovi> zajednickeOcjeneKorisnik2 = new List<Database.Dojmovi>();

            var preporucenaJelaIds = new List<int>();

            foreach (var item in dojmovi)
            {
                foreach (var dojam in dojmoviKorisnik)
                {
                    if (item.Value.Any(x => x.JeloId == dojam.JeloId))
                    {
                        zajednickeOcjeneKorisnik.Add(dojam);
                        zajednickeOcjeneKorisnik2.Add(item.Value.FirstOrDefault(e => e.JeloId == dojam.JeloId));
                    }
                }
                double slicnost = GetSlicnost(zajednickeOcjeneKorisnik, zajednickeOcjeneKorisnik2);
                if (slicnost > 0.5)
                {
                    var dobroOcjenjenaJelaIds = dojmovi
                        .Select(e => e.Value)
                        .SelectMany(e => e)
                        .Where(e => e.Ocjena >= 3)
                        .Select(e => e.JeloId)
                        .Where(e => !preporucenaJelaIds.Contains((int)e))
                        .ToList();

                    dobroOcjenjenaJelaIds.ForEach(e => {
                        if (!preporucenaJelaIds.Contains((int)e))
                            preporucenaJelaIds.Add((int)e);
                    });
                }
                zajednickeOcjeneKorisnik.Clear();
                zajednickeOcjeneKorisnik2.Clear();
            }

            var preporucenaJela = context.Set<Database.Jelo>()
                .Where(x => preporucenaJelaIds.Contains(x.Id))
                .ToList();
            var result = mapper.Map<List<Model.Jelo>>(preporucenaJela);
            return result;
        }



        private double GetSlicnost(List<Database.Dojmovi> zajednickeOcjene1, List<Database.Dojmovi> zajednickeOcjene2)
        {
            if (zajednickeOcjene1.Count != zajednickeOcjene2.Count)
                return 0;

            int? brojnik = 0, nazivnik1 = 0, nazivnik2 = 0;
            for (int i = 0; i < zajednickeOcjene1.Count; i++)
            {
                brojnik += zajednickeOcjene1[i].Ocjena * zajednickeOcjene2[i].Ocjena;
                nazivnik1 += zajednickeOcjene1[i].Ocjena * zajednickeOcjene1[i].Ocjena;
                nazivnik2 += zajednickeOcjene2[i].Ocjena * zajednickeOcjene2[i].Ocjena;
            }
            nazivnik1 = (int?)Math.Sqrt((double)nazivnik1);
            nazivnik2 = (int?)Math.Sqrt((double)nazivnik2);
            int? nazivnik = nazivnik1 * nazivnik2;
            if (nazivnik == 0)
                return 0;
            else
                return (double)(brojnik / nazivnik);
        }



        public override IQueryable<Jelo> AddFilter(IQueryable<Jelo> query, JeloSearchObject search = null)
        {
            var filter = base.AddFilter(query, search);

            if (!string.IsNullOrWhiteSpace(search?.Naziv))
            {
                filter = filter.Where(w => w.Naziv.Contains(search.Naziv));
            }
            if(!string.IsNullOrWhiteSpace(search?.KategorijaNaziv))
            {
                filter = filter.Where(w => w.Kategorija.Naziv.Contains(search.KategorijaNaziv));
            }


            return filter;
        }



    }
}
