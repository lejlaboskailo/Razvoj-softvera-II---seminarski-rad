using eRestoran.Services;
using Microsoft.AspNetCore.Mvc;

namespace eRestoran.Controllers
{
    public class BaseController<T, TSearch> : ControllerBase where T : class where TSearch : class
    {
        public IService<T, TSearch> Service { get; set; }
        public BaseController(IService<T, TSearch> service)
        {
            Service = service;
        }

        [HttpGet]
        public virtual IEnumerable<T> Get([FromQuery] TSearch search = null)
        {
            return Service.Get(search);
        }

        [HttpGet]
        public virtual T GetById(int id)
        {
            return Service.GetById(id);
        }
    }
}
