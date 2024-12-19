//using eRestoran.Model;
//using eRestoran.Services.Database;
//using iTextSharp.text;
//using Microsoft.EntityFrameworkCore;
//using System;
//using System.Collections.Generic;
//using System.Linq;
//using System.Text;
//using System.Threading.Tasks;

//namespace eRestoran.Services.Reports
//{
//    public class ReportService:IReportService
//    {
//        private readonly ERestoranContext _context;

//        public ReportService(ERestoranContext context)
//        {
//            _context = context;
//        }

//       /* public async Task<UplatePoKorisniku> ReportUplatePoKorisniku()
//        {
//            var narudzbe = await _context.Narudzbas
//         .Where(n => n.DatumNarudzbe.HasValue && n.DatumNarudzbe.Value.Year == godina)
//         .Include(n => n.StavkeNarudzbes) 
//         .Include(n => n.Korisnik) 
//         .ToListAsync();

//            var izvjestaj = new UplatePoKorisniku
//            {
//                UkupniPromet = (int)narudzbe.Sum(n => n.StavkeNarudzbes.Sum(s => s.Cijena * s.Kolicina)),
//                ProdajaPoKorisniku = narudzbe
//                    .Where(n => n.KorisnikId.HasValue) 
//                    .GroupBy(n => n.KorisnikId.Value)
//                    .Select(g => new ProdajaPoKorisniku
//                    {
//                        KorisnikId = g.Key,
//                        Ime = g.FirstOrDefault().Korisnik?.Ime, 
//                        Prezime = g.FirstOrDefault().Korisnik?.Prezime,
//                        UkupniIznos = (int)g.Sum(n => n.StavkeNarudzbes.Sum(s => s.Cijena * s.Kolicina))
//                    })
//                    .ToList()
//            };

//            return izvjestaj;
//        }*/

//        public List<UplatePoKorisniku> ReportUplatePoKorisniku()
//        {
//            var uplate = _context.Uplata
//        .Include(u => u.Korisnik) // Povezivanje s tabelom Korisnik
//        .Select(u => new UplatePoKorisniku
//        {
//            Iznos = u.Iznos,
//            DatumTransakcije = u.DatumTransakcije,
//            BrojTransakcije = u.BrojTransakcije,
//            ImeKorisnika = u.Korisnik.Ime,
//            PrezimeKorisnika = u.Korisnik.Prezime,
//            NacinPlacanja = u.NacinPlacanja
//        })
//        .ToList();

//            return uplate;
//        }
//        //public List<PrometPoKorisniku> PrometPoKorisniku()
//        //{
//        //    //prekoNarudzbe
//        //    var uplate = _context.Uplata
//        //.Include(u => u.Korisnik) // Povezivanje s tabelom Korisnik
//        //.Select(u => new UplatePoKorisniku
//        //{
//        //    Iznos = u.Iznos,
//        //    DatumTransakcije = u.DatumTransakcije,
//        //    BrojTransakcije = u.BrojTransakcije,
//        //    ImeKorisnika = u.Korisnik.Ime,
//        //    PrezimeKorisnika = u.Korisnik.Prezime,
//        //    NacinPlacanja = u.NacinPlacanja
//        //})
//        //.ToList();

//        //    return uplate;
//        //}

//        public List<PrometPoKorisniku> PrometPoKorisniku()
//        {
//            // Dohvaćanje narudžbi s povezanim podacima iz posljednjih godinu dana
//            var godinaUnazad = DateTime.Now.AddYears(-1);

//            var promet = _context.Narudzbas
//                .Include(n => n.Korisnik) // Povezivanje s tabelom Korisnik
//                .Select(n => new PrometPoKorisniku
//                {
//                    ImeKorisnika = n.Korisnik.Ime + " " + n.Korisnik.Prezime, // Puno ime korisnika
//                    //NazivNarudzbe = n.NazivNarudzbe,
//                    DatumNarudzbe = n.DatumNarudzbe.ToString("yyyy-MM-dd") // Format datuma
//                })
//                .Where(p => DateTime.Parse(p.DatumNarudzbe) >= godinaUnazad) // Filtriramo po datumu
//                .ToList();

//            return promet;
//        }

//    }
//}

using eRestoran.Model;
using eRestoran.Services.Database;
using iTextSharp.text;
using iTextSharp.text.pdf;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using iTextSharp.text;
using iTextSharp.text.pdf;
using System.IO;

namespace eRestoran.Services.Reports
{
    public class ReportService : IReportService
    {
        private readonly ERestoranContext _context;

        public ReportService(ERestoranContext context)
        {
            _context = context ?? throw new ArgumentNullException(nameof(context));
        }

        public List<UplatePoKorisniku> ReportUplatePoKorisniku()
        {
            var uplate = _context.Uplata
                .Include(u => u.Korisnik)
                .Select(u => new UplatePoKorisniku
                {
                    Iznos = u.Iznos,
                    DatumTransakcije = u.DatumTransakcije,
                    BrojTransakcije = u.BrojTransakcije,
                    ImeKorisnika = u.Korisnik.Ime,
                    PrezimeKorisnika = u.Korisnik.Prezime,
                    NacinPlacanja = u.NacinPlacanja
                })
                .ToList();

            return uplate;
        }

        //public List<PrometPoKorisniku> ReportPrometPoKorisniku()
        //{
        //    var godinaUnazad = DateTime.Now.AddYears(-1);

        //    var promet = _context.Narudzbas
        //        .Include(n => n.Korisnik)
        //        .Where(n => n.DatumNarudzbe != null && n.DatumNarudzbe >= godinaUnazad)
        //        .Select(n => new PrometPoKorisniku
        //        {
        //            ImeKorisnika = n.Korisnik.Ime + " " + n.Korisnik.Prezime,

        //            DatumNarudzbe = n.DatumNarudzbe.ToString() // Provjera da nije null prije formatiranja
        //        })
        //        .ToList();

        //    return promet;
        //}

        public List<PrometPoKorisniku> ReportPrometPoKorisniku()
        {
            var godinaUnazad = DateTime.Now.AddYears(-1);

            var promet = _context.Narudzbas
                .Include(n => n.Korisnik) // Povezivanje s tabelom Korisnik
                .Include(n => n.StavkeNarudzbes) // Povezivanje s tabelom StavkeNarudzbe
                    .ThenInclude(s => s.Jelo) // Povezivanje StavkeNarudzbe -> Jelo
                    .ThenInclude(j => j.Kategorija) // Povezivanje Jelo -> Kategorija
                .Where(n => n.DatumNarudzbe != null && n.DatumNarudzbe >= godinaUnazad)
                .Select(n => new PrometPoKorisniku
                {
                    ImeKorisnika = n.Korisnik.Ime + " " + n.Korisnik.Prezime,
                    DatumNarudzbe = n.DatumNarudzbe.ToString(),
                    NazivKategorije = n.StavkeNarudzbes
                        .Select(s => s.Jelo.Kategorija.Naziv) // Pretpostavka: Kategorija ima polje Naziv
                        .FirstOrDefault() ?? "N/A" // Uzimamo prvu kategoriju ili N/A ako nema
                })
                .ToList();

            return promet;
        }

        public byte[] GenerisiPdfPromet(List<PrometPoKorisniku> promet)
        {
            using (var stream = new MemoryStream())
            {
                var document = new Document();
                PdfWriter.GetInstance(document, stream);
                document.Open();

                // Dodavanje naslova
                var titleFont = FontFactory.GetFont(FontFactory.HELVETICA_BOLD, 16);
                var title = new Paragraph("Izvještaj o prometu po korisnicima", titleFont)
                {
                    Alignment = Element.ALIGN_CENTER
                };
                document.Add(title);

                // Dodavanje prostora
                document.Add(new Paragraph("\n"));

                // Kreiranje tabele
                var table = new PdfPTable(3) { WidthPercentage = 100 }; // 3 kolone: Ime, Datum, Kategorija
                table.AddCell("Ime i Prezime");
                table.AddCell("Datum Narudžbe");
                table.AddCell("Kategorija");

                foreach (var p in promet)
                {
                    table.AddCell(p.ImeKorisnika ?? "N/A");
                    table.AddCell(p.DatumNarudzbe ?? "N/A");
                    table.AddCell(p.NazivKategorije ?? "N/A");
                }

                document.Add(table);
                document.Close();

                return stream.ToArray(); // Vraćamo PDF kao bajt niz
            }
        }
    }
}
