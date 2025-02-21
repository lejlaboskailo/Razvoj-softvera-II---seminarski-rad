using AutoMapper;
using eRestoran.Model.Requests;
using eRestoran.Model.SearchObjects;
using eRestoran.Services;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace eRestoran.Controllers
{
    [Route("[controller]")]
    public class KorpaController : BaseCRUDController<Model.Korpa, BaseSearchObject, KorpaInsertRequest, KorpaUpdateRequest>
    {

        private readonly IMapper _mapper;
        public KorpaController(ILogger<BaseController<Model.Korpa, BaseSearchObject>> logger, IKorpaService service, IMapper mapper) : base(logger, service)
        {
            _mapper = mapper;
        }
    }
}
