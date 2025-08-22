using eRestoran.Model;
using eRestoran.Model.Requests;
using eRestoran.Model.SearchObjects;
using eRestoran.Services;
using eRestoran.Services.Reports;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace eRestoran.Controllers
{
    [Route("[controller]")]
    public class PriloziController : BaseController<Model.Prilozi, PriloziSearchObject>
    {
        public PriloziController(ILogger<BaseController<Prilozi, PriloziSearchObject>> logger, IPriloziService service) : base(logger, service)
        {
        }
    }
}
