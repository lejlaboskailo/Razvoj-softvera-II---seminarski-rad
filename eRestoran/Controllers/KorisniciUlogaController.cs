using eRestoran.Model.Requests;
using eRestoran.Model.SearchObjects;
using eRestoran.Services;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace eRestoran.Controllers
{
    [Route("[controller]")]
    public class KorisniciUlogaController : BaseCRUDController<Model.KorisniciUloge, KorisniciUlogaSearchRequest, KorisniciUlogeInsertRequest, KorisniciUlogeUpdateRequest>
    {
        public KorisniciUlogaController(ILogger<BaseController<Model.KorisniciUloge, KorisniciUlogaSearchRequest>> logger, IKorisniciUloga service) : base(logger, service)
        {
        }
    }
}
