/*using AutoMapper;
using eRestoran.Services;
using eRestoran.Services.Database;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using eRestoran.Model.SearchObjects;
using eRestoran.Model.Requests;
using Microsoft.AspNetCore.Mvc;

namespace eRestoran.Services
{
    public class JeloService : BaseCRUDService<Model.Jelo, Database.Jelo, JeloSearchObject, JeloInsertRequest, JeloUpdateRequest>, IJeloService
    {
        public JeloService(ERestoranContext context, IMapper mapper) : base(context, mapper)
        {
            _context = _context;
            _mapper = _mapper;
        }


     
        public List<Model.Jelo> GetPreporucenaJela(int korisnikId)
        {
            var korisnici = _context.Korisnicis.Where(e => e.Id != korisnikId).ToList();
            Dictionary<Database.Korisnici, List<Database.Dojmovi>> dojmovi = new Dictionary<Database.Korisnici, List<Database.Dojmovi>>();
            foreach (var korisnik in korisnici)
            {
                var ocjene = _context.Dojmovis
                    .Where(e => e.KorisnikId == korisnik.Id)
                    .ToList();
                dojmovi.Add(korisnik, ocjene);
            }
            var dojmoviKorisnik = _context.Dojmovis.Where(e => e.KorisnikId == korisnikId).ToList();

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

            var preporucenaJela = _context.Set<Database.Jelo>()
                .Where(x => preporucenaJelaIds.Contains(x.Id))
                .ToList();
            var result = _mapper.Map<List<Model.Jelo>>(preporucenaJela);
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

        public override IQueryable<Jelo> AddFilter(IQueryable<Jelo> query, JeloSearchObject? search = null)
        {
            var filter = base.AddFilter(query, search);

            if (!string.IsNullOrWhiteSpace(search?.Naziv))
            {
                filter = filter.Where(w => w.Naziv.Contains(search.Naziv.ToLower()));
            }
            if(!string.IsNullOrWhiteSpace(search?.KategorijaNaziv))
            {
                filter = filter.Where(w => w.Kategorija.Naziv.Contains(search.KategorijaNaziv.ToLower()));
            }
            return filter;
        }
    }
}
*/

using AutoMapper;
using eRestoran.Services;
using eRestoran.Services.Database;
using Microsoft.EntityFrameworkCore;
using Microsoft.AspNetCore.Mvc;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Threading.Tasks;
using eRestoran.Model.SearchObjects;
using eRestoran.Model.Requests;

namespace eRestoran.Services
{
    public class JeloService : BaseCRUDService<Model.Jelo, Database.Jelo, JeloSearchObject, JeloUpsertRequest, JeloUpsertRequest>, IJeloService
    {
        public JeloService(ERestoranContext context, IMapper mapper) : base(context, mapper)
        {
            _context = context;
            _mapper = mapper;
        }

        /*public IActionResult UploadImage([FromBody] ImageUploadRequest request)
        {
            if (string.IsNullOrWhiteSpace(request?.Image))
            {
                return new BadRequestObjectResult("No image provided");
            }

            try
            {
                byte[] imageBytes = Convert.FromBase64String(request.Image);
                string filePath = Path.Combine("wwwroot/images", $"{Guid.NewGuid()}.jpg"); // Generiši jedinstveno ime fajla
                System.IO.File.WriteAllBytes(filePath, imageBytes);
                return new OkObjectResult("Image uploaded successfully");
            }
            catch (Exception ex)
            {
                return new BadRequestObjectResult($"Error uploading image: {ex.Message}");
            }
        }*/

        public List<Model.Jelo> GetPreporucenaJela(int trenutniKorisnikId)
        {
            // Pronađi samo ocjene za trenutnog korisnika
            var korisnici = _context.Korisnicis.ToList();
            Dictionary<Database.Korisnici, List<Database.Dojmovi>> dojmovi = new Dictionary<Database.Korisnici, List<Database.Dojmovi>>();

            foreach (var korisnik in korisnici)
            {
                var ocjene = _context.Dojmovis
                    .Where(e => e.KorisnikId == korisnik.Id)
                    .ToList();
                dojmovi.Add(korisnik, ocjene);
            }

            var zajednickeOcjeneKorisnik = new List<Database.Dojmovi>();
            var zajednickeOcjeneKorisnik2 = new List<Database.Dojmovi>();
            var preporucenaJelaIds = new HashSet<int>();

            // Pretražuj samo sve korisnike osim trenutnog korisnika
            foreach (var korisnik1 in dojmovi)
            {
                // Skip korisnik1 ako je trenutni korisnik
                if (korisnik1.Key.Id == trenutniKorisnikId) continue;

                foreach (var korisnik2 in dojmovi)
                {
                    if (korisnik1.Key.Id == korisnik2.Key.Id) continue;

                    // Nađite zajedničke ocene između korisnika
                    foreach (var ocjena1 in korisnik1.Value)
                    {
                        if (korisnik2.Value.Any(x => x.JeloId == ocjena1.JeloId))
                        {
                            zajednickeOcjeneKorisnik.Add(ocjena1);
                            zajednickeOcjeneKorisnik2.Add(korisnik2.Value.FirstOrDefault(x => x.JeloId == ocjena1.JeloId));
                        }
                    }

                    double slicnost = GetSlicnost(zajednickeOcjeneKorisnik, zajednickeOcjeneKorisnik2);
                    if (slicnost > 0.5)
                    {
                        var dobroOcjenjenaJelaIds = korisnik2.Value
                            .Where(e => e.Ocjena >= 3)
                            .Select(e => e.JeloId)
                            .ToList();

                        foreach (var jeloId in dobroOcjenjenaJelaIds)
                        {
                            preporucenaJelaIds.Add((int)jeloId);
                        }
                    }

                    zajednickeOcjeneKorisnik.Clear();
                    zajednickeOcjeneKorisnik2.Clear();
                }
            }

            var preporucenaJela = _context.Set<Database.Jelo>()
                .Where(x => preporucenaJelaIds.Contains(x.JeloId))
                .ToList();

            var result = _mapper.Map<List<Model.Jelo>>(preporucenaJela);
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

        public override IQueryable<Jelo> AddFilter(IQueryable<Jelo> query, JeloSearchObject? search = null)
        {
            var filter = base.AddFilter(query, search);

            if (!string.IsNullOrWhiteSpace(search?.Naziv))
            {
                filter = filter.Where(w => w.Naziv.ToLower().Contains(search.Naziv.ToLower()));
            }
            if (!string.IsNullOrWhiteSpace(search?.KategorijaNaziv))
            {
                filter = filter.Where(x => x.Kategorija.Naziv == search.KategorijaNaziv);
            }
            if (search?.KategorijaId != null && search.KategorijaId > 0)
            {
                filter = filter.Where(x => x.KategorijaId == search.KategorijaId);
            }
            return filter;
        }

    }

}