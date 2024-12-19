using eRestoran.Model;
using eRestoran.Model.SearchObjects;
using eRestoran.Services;
using Microsoft.AspNetCore.Components;

namespace eRestoran.Controllers
{
    [Route("[controller]")]
    public class UlogaController:BaseController<Model.Uloge,UlogeSearchObject>
    {
        public UlogaController(ILogger<BaseController<Uloge, UlogeSearchObject>> logger, IUlogaService service) : base(logger, service)
        {
        }
    }
}
