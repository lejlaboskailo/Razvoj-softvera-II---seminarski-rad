using eRestoran.Model;
using eRestoran.Model.Requests;
using eRestoran.Model.SearchObjects;
using eRestoran.Services;
using Microsoft.AspNetCore.Mvc;

namespace eRestoran.Controllers
{
    [Route("[controller]")]
    public class DrzavaController : BaseController<Model.Drzava, DrzavaSearchObject>
    {
        public DrzavaController(ILogger<BaseController<Drzava, DrzavaSearchObject>> logger, IDrzavaService service) : base(logger, service)
        {
        }
    }
}
