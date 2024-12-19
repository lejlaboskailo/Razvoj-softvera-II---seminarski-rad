using Microsoft.AspNetCore.Mvc;
using System.Collections.Generic;
using System.Threading.Tasks; 
using eRestoran.Services.Reports;
using eRestoran.Model;
using System.Reflection.Metadata;
using iText.Kernel.Pdf;
using iText.Layout.Element;
using iText.Layout;
namespace eRestoran.Controllers
{
    [Route("[controller]")]
    public class ReportController:ControllerBase
    {
        private readonly IReportService reportService;
        public ReportController(IReportService _reportService)
        {
            reportService = _reportService;
        }

        [HttpGet("reportUplatePoKorisniku")]
        public ActionResult<UplatePoKorisniku> ReportUplatePoKorisniku()
        {
            var izvjestaj = reportService.ReportUplatePoKorisniku();
            return Ok(izvjestaj);
        }

        [HttpGet("reportPrometPoKorisniku")]
        public ActionResult<List<PrometPoKorisniku>> GetPrometPoKorisniku()
        {
            try
            {
                var promet = reportService.ReportPrometPoKorisniku();
                return Ok(promet);
            }
            catch (Exception ex)
            {
                return StatusCode(500, $"Greška na serveru: {ex.Message}");
            }
        }

        [HttpGet("print-promet")]
        public async Task<IActionResult> PrintIzvjestajOPrometu()
        {
            // Dohvatimo izvještaj o prometu po korisnicima
            var promet = await Task.Run(() => reportService.ReportPrometPoKorisniku());

            using (var stream = new MemoryStream())
            {
                var writer = new iText.Kernel.Pdf.PdfWriter(stream);
                var pdf = new iText.Kernel.Pdf.PdfDocument(writer);
                var document = new iText.Layout.Document(pdf);

                // Dodaj naslov izvještaja
                var naslov = new iText.Layout.Element.Paragraph("Izvještaj o prometu po korisnicima")
                    .SetTextAlignment(iText.Layout.Properties.TextAlignment.CENTER)
                    .SetFontSize(18)
                    .SetBold();
                document.Add(naslov);

                // Dodaj razmak
                document.Add(new iText.Layout.Element.Paragraph("\n"));

                // Dodaj sadržaj izvještaja
                foreach (var item in promet)
                {
                    document.Add(new iText.Layout.Element.Paragraph(
                        $"{item.ImeKorisnika} - {item.DatumNarudzbe} - {item.NazivKategorije ?? "Bez kategorije"}"
                    ));
                }

                document.Close();

                // Vraćamo PDF kao fajl
                return File(stream.ToArray(), "application/pdf", "IzvjestajPrometPoKorisnicima.pdf");
            }
        }
        /*
        [HttpGet("uplate")]
        public async Task<ActionResult<List<Uplata>>> DobiIzvjestajOUplatama()
        {
            var izvjestaj = await reportService.DobiIzvjestajOUplatamaAsync();
            return Ok(izvjestaj);
        }

        [HttpGet("print-uplate/{korisnikId}")]
        public async Task<IActionResult> PrintIzvjestajOUplatama()
        {
            var uplate = await reportService.DobiIzvjestajOUplatamaAsync();

            using (var stream = new MemoryStream())
            {
                var writer = new PdfWriter(stream);
                var pdf = new PdfDocument(writer);
                var document = new iText.Layout.Document(pdf);

                // Dodaj sadržaj izvještaja
                foreach (var uplat in uplate)
                {
                    document.Add(new Paragraph($"{uplat.Korisnik.Ime} {uplat.Korisnik.Prezime} - {uplat.Iznos} - {uplat.DatumTransakcije}"));
                }

                document.Close();
                return File(stream.ToArray(), "application/pdf", "IzvjestajOUplatama.pdf");
            }
        }*/

    }
}
