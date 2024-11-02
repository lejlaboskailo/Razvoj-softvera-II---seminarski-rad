using eRestoran.Model.Requests;
using eRestoran.Services;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace eRestoran.Controllers
{
    [Route("[controller]")]
   // [AllowAnonymous]
    public class KategorijaController:BaseCRUDController<Model.Kategorija,KategorijaSearchRequest,KategorijaInsertRequest,KategorijaUpdateRequest>
    {
        public KategorijaController(ILogger<BaseController<Model.Kategorija, KategorijaSearchRequest>> logger, IKategorijaService service) : base(logger, service)
        {
        }
        public override Task<Model.Kategorija> Insert([FromBody] KategorijaInsertRequest insert)
        {
            return base.Insert(insert);
        }
    }
}
