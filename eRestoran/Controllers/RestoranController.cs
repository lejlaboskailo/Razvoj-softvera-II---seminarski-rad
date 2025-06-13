using eRestoran.Model;
using eRestoran.Model.Requests;
using eRestoran.Model.SearchObjects;
using eRestoran.Services;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace eRestoran.Controllers
{
    [Route("[controller]")]
    public class RestoranController : BaseCRUDController<Model.Restoran, BaseSearchObject, RestoranInsertRequest, RestoranUpdateRequest>
    {
        public RestoranController(ILogger<BaseController<Restoran, BaseSearchObject>> logger, IRestoranService service) : base(logger, service)
        {
        }
    }
}
