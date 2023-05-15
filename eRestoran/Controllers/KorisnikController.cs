using eRestoran.Model.Requests;
using eRestoran.Services;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using System.Text;

namespace eRestoran.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    [AllowAnonymous]
    public class KorisnikController:BaseCRUDController<Model.Korisnik,KorisnikSearchRequests,KorisnikUpsertRequest,KorisnikUpsertRequest>
    {
        protected readonly IKorisniciService _service;
        public KorisnikController(IKorisniciService service):base(service)
        {
            _service = service;
        }
        [HttpGet("Authenticate")]
        [AllowAnonymous]
        public async Task<Model.Korisnik> Authenticate()
        {
            string authorization = HttpContext.Request.Headers["Authorization"];

            string encodedHeader = authorization["Basic ".Length..].Trim();

            Encoding encoding = Encoding.GetEncoding("iso-8859-1");
            string usernamePassword = encoding.GetString(Convert.FromBase64String(encodedHeader));

            int seperatorIndex = usernamePassword.IndexOf(':');

            return await _service.Login(usernamePassword.Substring(0, seperatorIndex), usernamePassword[(seperatorIndex + 1)..]);
        }
    }
}
