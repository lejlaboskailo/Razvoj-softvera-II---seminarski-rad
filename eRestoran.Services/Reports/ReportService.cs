

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
            var lista = _context.Narudzbas
                .AsNoTracking()
                .Include(n => n.Korisnik)
                .Include(n => n.StavkeNarudzbes)
                .Where(n => n.PaymentId != null) // samo plaćene narudžbe
                .Select(n => new UplatePoKorisniku
                {
                    ImeKorisnika = n.Korisnik != null ? n.Korisnik.Ime : "N/A",
                    PrezimeKorisnika = n.Korisnik != null ? n.Korisnik.Prezime : "N/A",

                    // ukupni iznos = suma stavki
                    Iznos = n.StavkeNarudzbes
                            .Select(s => (decimal?)((s.Cijena ?? 0) * (s.Kolicina ?? 0)))
                            .Sum() ?? 0m,

                    DatumTransakcije = n.DatumNarudzbe,
                    BrojTransakcije = n.PaymentId!, // PaymentId tretiramo kao broj transakcije

                    // Ako PaymentId nije null => kartica
                    NacinPlacanja = n.PaymentId != null ? "Kartica" : "Nepoznato"
                })
                .OrderByDescending(x => x.DatumTransakcije)
                .ToList();

            return lista;
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
                .Include(n => n.Korisnik) 
                .Include(n => n.StavkeNarudzbes) 
                    .ThenInclude(s => s.Jelo)
                    .ThenInclude(j => j.Kategorija) 
                .Where(n => n.DatumNarudzbe != null && n.DatumNarudzbe >= godinaUnazad)
                .Select(n => new PrometPoKorisniku
                {
                    ImeKorisnika = n.Korisnik.Ime + " " + n.Korisnik.Prezime,
                    DatumNarudzbe = n.DatumNarudzbe.ToString(),
                    NazivKategorije = n.StavkeNarudzbes
                        .Select(s => s.Jelo.Kategorija.Naziv) 
                        .FirstOrDefault() ?? "N/A"
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

                var titleFont = FontFactory.GetFont(FontFactory.HELVETICA_BOLD, 16);
                var title = new Paragraph("Izvještaj o prometu po korisnicima", titleFont)
                {
                    Alignment = Element.ALIGN_CENTER
                };
                document.Add(title);

                document.Add(new Paragraph("\n"));

                var table = new PdfPTable(3) { WidthPercentage = 100 };
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

                return stream.ToArray(); 
            }
        }
    }
}
