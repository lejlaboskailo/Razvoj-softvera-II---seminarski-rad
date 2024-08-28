using eRestoran.Model;
using eRestoran.Model.SearchObjects;
using eRestoran.Services;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace eRestoran.Controllers
{
    [Route("[controller]")]
    public class StatusNarudzbeController:BaseController<Model.StatusNarudzbe,StatusNarudzbeSearchObject>
    {
        protected readonly IStatusNarudzbeService service;
        public StatusNarudzbeController(ILogger<BaseController<StatusNarudzbe, StatusNarudzbeSearchObject>> logger, IStatusNarudzbeService service) : base(logger, service)
        {
        }

    }
}
