using eRestoran.Model;
using eRestoran.Model.SearchObjects;
using eRestoran.Services;
using Microsoft.AspNetCore.Components;

namespace eRestoran.Controllers
{
    [Route("[controller]")]
    public class GradController : BaseController<Model.Grad, GradSearchObject>
    {
        public GradController(ILogger<BaseController<Grad, GradSearchObject>> logger, IGradService service) : base(logger, service)
        {
        }
    }
}
