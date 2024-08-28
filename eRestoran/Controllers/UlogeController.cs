using eRestoran.Model;
using eRestoran.Model.SearchObjects;
using eRestoran.Services;
using Microsoft.AspNetCore.Components;

namespace eRestoran.Controllers
{
    [Route("[controller]")]
    public class UlogeController:BaseController<Model.Uloge,UlogeSearchObject>
    {
        public UlogeController(ILogger<BaseController<Uloge, UlogeSearchObject>> logger, IUlogeService service) : base(logger, service)
        {
        }
    }
}
