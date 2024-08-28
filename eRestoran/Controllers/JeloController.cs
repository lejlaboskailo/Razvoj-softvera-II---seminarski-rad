using eRestoran.Model.SearchObjects;
using eRestoran.Services;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace eRestoran.Controllers
{
    
    [Route("[controller]")]
    [AllowAnonymous]
    public class JeloController:BaseCRUDController<Model.Jelo,JeloSearchObject,JeloUpsertRequest,JeloUpsertRequest>
    {
        public JeloController(ILogger<BaseController<Model.Jelo, JeloSearchObject>> logger, IJeloService service) : base(logger, service)
        {
        }


        /* [HttpGet("preporuceno/{korisnikId}")]
         public List<Model.Jelo>GetPreporucenaJela(int korisnikId)
         {
             return service.GetPreporucenaJela(korisnikId);
         }*/
    }
}
