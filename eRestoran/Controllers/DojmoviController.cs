using eRestoran.Controllers;
using eRestoran.Model;
using eRestoran.Model.Requests;
using eRestoran.Model.SearchObjects;
using eRestoran.Services;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace eRestoran.Controllers
{
    [Route("[controller]")]
    //[AllowAnonymous]
    public class DojmoviController : BaseCRUDController<Model.Dojmovi,DojmoviSearchObject, DojmoviInsertRequest, DojmoviUpsertRequest>
    {
        public DojmoviController(ILogger<BaseController<Model.Dojmovi, DojmoviSearchObject>> logger, IDojmoviService service) : base(logger, service)
        {
        }
    }
}


