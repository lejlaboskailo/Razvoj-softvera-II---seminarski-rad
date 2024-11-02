using eRestoran.Model.Requests;
using eRestoran.Model.SearchObjects;
using eRestoran.Services;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using System.Text;

namespace eRestoran.Controllers
{
    [Route("[controller]")]
   //[AllowAnonymous]
    public class KorisnikController:BaseCRUDController<Model.Korisnik,KorisnikSearchRequests,KorisnikUpsertRequest,KorisnikUpsertRequest>
    {
        public KorisnikController(ILogger<BaseController<Model.Korisnik, KorisnikSearchRequests>> logger, IKorisniciService service) : base(logger, service)
        {
        }
        [HttpPost("login")]
        [AllowAnonymous]
        public Task<Model.Korisnik> Login(string username, string password)
        {
            return (_service as IKorisniciService).Login(username, password);
        }
        [HttpGet("Authenticate")]
        [AllowAnonymous]

        public Task<Model.Korisnik> Authenticate()
        {
            string authorization = HttpContext.Request.Headers["Authorization"];

            string encodedHeader = authorization["Basic ".Length..].Trim();

            Encoding encoding = Encoding.GetEncoding("iso-8859-1");
            string usernamePassword = encoding.GetString(Convert.FromBase64String(encodedHeader));

            int seperatorIndex = usernamePassword.IndexOf(':');

            return ((IKorisniciService)_service).Login(usernamePassword.Substring(0, seperatorIndex), usernamePassword[(seperatorIndex + 1)..]);
        }

    }
}
