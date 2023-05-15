using eRestoran.Model.Requests;
using eRestoran.Model.SearchObjects;
using eRestoran.Services;
using Microsoft.AspNetCore.Mvc;

namespace eRestoran.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class DrzavaController : BaseController<Model.Drzava, DrzavaSearchObject>
    {
        public IDrzavaService _drzavaService { get; set; }
        public DrzavaController(IDrzavaService service):base(service)
        {
            _drzavaService = service;
        }
    }
}
