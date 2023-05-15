using eRestoran.Model.Requests;
using eRestoran.Services;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace eRestoran.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    [AllowAnonymous]
    public class KategorijaController:BaseCRUDController<Model.Kategorija,KategorijaSearchRequest,KategorijaUpsertRequest,KategorijaUpsertRequest>
    {
        public KategorijaController(IKategorijaService service) : base(service)
        { 
        }
    }
}
