using eRestoran.Services;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace eRestoran.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    [Authorize]
    public class BaseCRUDController<T, TSearch, TInsert, TUpdate> : BaseController<T, TSearch>
            where T : class where TSearch : class where TInsert : class where TUpdate : class
    {
        public BaseCRUDController(ICRUDService<T, TSearch, TInsert, TUpdate> service) : base(service)
        {

        }

        [HttpPost]
        public virtual T Insert([FromBody] TInsert insert)
        {
            var result = ((ICRUDService<T, TSearch, TInsert, TUpdate>)this._service).Insert(insert);

            return result;
        }
        [HttpPut("{id}")]
        public virtual T Update(int id, [FromBody] TUpdate update)
        {
            var result = ((ICRUDService<T, TSearch, TInsert, TUpdate>)this._service).Update(id, update);

            return result;
        }

        [HttpDelete("{id}")]
        public virtual T Delete(int id)
        {
            var result = ((ICRUDService<T, TSearch, TInsert, TUpdate>)this._service).Delete(id);

            return result;
        }
    }
}
