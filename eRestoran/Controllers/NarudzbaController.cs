using eRestoran.Controllers;
using eRestoran.Model;
using eRestoran.Model.Requests;
using eRestoran.Model.SearchObjects;
using eRestoran.Services;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using System.Text;

namespace eRestoran.Controllers
{
    [Route("[controller]")]
   // [AllowAnonymous]
    public class NarudzbaController:BaseCRUDController<Model.Narudzba,NarudzbaSearchObject,NarudzbaInsertRequest,NarudzbaUpdateRequest>
    {
        protected readonly INarudzbaService _service;
        public NarudzbaController(ILogger<BaseController<Model.Narudzba, NarudzbaSearchObject>> logger, INarudzbaService service) : base(logger, service)
        {
        }

        [HttpPut("{id}/activate")]
        public virtual async Task<Narudzba> Activate(int id)
        {
            return await (_service as INarudzbaService).Activate(id);
        }


        [HttpPut("{id}/hide")]
        public virtual async Task<Narudzba> Hide(int id)
        {
            return await (_service as INarudzbaService).Hide(id);
        }

        [HttpGet("{id}/allowedActions")]
        public virtual async Task<List<string>> AllowedActions(int id)
        {
            return await (_service as INarudzbaService).AllowedActions(id);
        }


        /*  [HttpGet("{id}/allowedActions")]
          public virtual async Task<List<string>> AllowedActions(int id)
          {
              return await _service.AllowedActions(id);
          }

          [HttpPut("{id}/accept")]
          public virtual async Task<Narudzba> Accept(int id)
          {
              return await _service.Accept(id);
          }

          [HttpPut("{id}/inProgress")]
          public virtual async Task<Narudzba> inProgress(int id)
          {
              return await _service.InProgress(id);
          }

          [HttpPut("{id}/finish")]
          public virtual async Task<Narudzba> Finish(int id)
          {
              return await _service.Finish(id);
          }

          [HttpPut("{id}/deliver")]
          public virtual async Task<Narudzba> Deliver(int id)
          {
              return await _service.Deliver(id);
          }

          [HttpPut("{id}/cancel")]
          public virtual async Task<Narudzba> Cancel(int id)
          {
              return await _service.Cancel(id);
          }*/
    }
}


