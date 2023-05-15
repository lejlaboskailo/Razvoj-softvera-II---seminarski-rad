using eRestoran.Model.SearchObjects;
using eRestoran.Services;

namespace eRestoran.Controllers
{
    public class GradController : BaseController<Model.Grad, GradSearchObject>
    {
        public IGradService gradService { get; set; }
        public GradController(IGradService service) : base(service)
        {
            gradService = service;
        }
    }
}
