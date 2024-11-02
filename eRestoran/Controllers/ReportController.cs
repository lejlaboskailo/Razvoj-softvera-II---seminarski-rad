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

        [HttpGet("promet")]
        public async Task<ActionResult<IzvjestajOPrometu>> DobiIzvjestajOPrometu(int godina)
        {
            var izvjestaj = await reportService.DobiIzvjestajOPrometuAsync(godina);
            return Ok(izvjestaj);
        }
        [HttpGet("uplate/{korisnikId}")]
        public async Task<ActionResult<List<Uplata>>> DobiIzvjestajOUplatama(int korisnikId)
        {
            var izvjestaj = await reportService.DobiIzvjestajOUplatamaAsync(korisnikId);
            return Ok(izvjestaj);
        }

        [HttpGet("print-uplate/{korisnikId}")]
        public async Task<IActionResult> PrintIzvjestajOUplatama(int korisnikId)
        {
            var uplate = await reportService.DobiIzvjestajOUplatamaAsync(korisnikId);

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
        }

    }
}
