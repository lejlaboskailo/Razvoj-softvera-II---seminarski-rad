using eRestoran.Model;
using eRestoran.Services.Database;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eRestoran.Services.Reports
{
    public class ReportService:IReportService
    {
        private readonly ERestoranContext _context;

        public ReportService(ERestoranContext context)
        {
            _context = context;
        }

        public async Task<IzvjestajOPrometu> DobiIzvjestajOPrometuAsync(int godina)
        {
            var narudzbe = await _context.Narudzbas
         .Where(n => n.DatumNarudzbe.HasValue && n.DatumNarudzbe.Value.Year == godina)
         .Include(n => n.StavkeNarudzbes) 
         .Include(n => n.Korisnik) 
         .ToListAsync();

            var izvjestaj = new IzvjestajOPrometu
            {
                UkupniPromet = (int)narudzbe.Sum(n => n.StavkeNarudzbes.Sum(s => s.Cijena * s.Kolicina)),
                ProdajaPoKorisniku = narudzbe
                    .Where(n => n.KorisnikId.HasValue) 
                    .GroupBy(n => n.KorisnikId.Value)
                    .Select(g => new ProdajaPoKorisniku
                    {
                        KorisnikId = g.Key,
                        Ime = g.FirstOrDefault().Korisnik?.Ime, 
                        Prezime = g.FirstOrDefault().Korisnik?.Prezime,
                        UkupniIznos = (int)g.Sum(n => n.StavkeNarudzbes.Sum(s => s.Cijena * s.Kolicina))
                    })
                    .ToList()
            };

            return izvjestaj;
        }

        public async Task<List<Uplatum>> DobiIzvjestajOUplatamaAsync(int korisnikId)
        {
            var uplate = await _context.Uplata
                .Where(u => u.KorisnikId == korisnikId)
                .Include(u => u.Korisnik) 
                .ToListAsync();

            return uplate;
        }
    }
}
