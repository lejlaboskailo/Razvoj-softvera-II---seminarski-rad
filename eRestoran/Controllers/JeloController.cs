using AutoMapper;
using eRestoran.Model.Requests;
using eRestoran.Model.SearchObjects;
using eRestoran.Services;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace eRestoran.Controllers
{
    [Route("[controller]")]
    // [AllowAnonymous]
    public class JeloController : BaseCRUDController<Model.Jelo, JeloSearchObject, JeloUpsertRequest, JeloUpsertRequest>
    {
        //public JeloController(ILogger<BaseController<Model.Jelo, JeloSearchObject>> logger, IJeloService service) : base(logger, service)
        //{
        //}
        //public override Task<Model.Jelo> Insert([FromBody] JeloInsertRequest insert)
        //{
        //    return base.Insert(insert);
        //}

        private readonly IMapper _mapper;
        public JeloController(ILogger<BaseController<Model.Jelo, JeloSearchObject>> logger, IJeloService service, IMapper mapper) : base(logger, service)
        {
            _mapper = mapper;
        }
        /*   [HttpGet("preporuceno/{korisnikId}")]
           public List<Model.Jelo>GetPreporucenaJela(int korisnikId)
           {
               return (_service as IJeloService).GetPreporucenaJela(korisnikId);
           }*/


        [HttpGet("preporuceno")]
        public List<Model.Jelo> GetPreporucenaJela(int korisnikId)
        {
            return (_service as IJeloService).GetPreporucenaJela();
        }
    }
}
