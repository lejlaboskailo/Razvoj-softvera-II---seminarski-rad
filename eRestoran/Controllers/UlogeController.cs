using eRestoran.Model.SearchObjects;
using eRestoran.Services;

namespace eRestoran.Controllers
{
    public class UlogeController:BaseController<Model.Uloge,UlogeSearchObject>
    {
        public UlogeController(IUlogeService service):base(service)
        {

        }
    }
}
