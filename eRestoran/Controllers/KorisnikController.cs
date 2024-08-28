using eRestoran.Model.Requests;
using eRestoran.Model.SearchObjects;
using eRestoran.Services;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using System.Text;

namespace eRestoran.Controllers
{
    [Route("[controller]")]
   [AllowAnonymous]
    public class KorisnikController:BaseCRUDController<Model.Korisnik,KorisnikSearchRequests,KorisnikUpsertRequest,KorisnikUpsertRequest>
    {
        public KorisnikController(ILogger<BaseController<Model.Korisnik, KorisnikSearchRequests>> logger, IKorisniciService service) : base(logger, service)
        {
        }

    }
}
