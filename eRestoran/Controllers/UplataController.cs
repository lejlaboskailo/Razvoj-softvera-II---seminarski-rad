using eRestoran.Controllers;
using eRestoran.Model.Requests;
using eRestoran.Model.SearchObjects;
using eRestoran.Services;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;



namespace eRestoran.Controllers
{
    [Route("[controller]")]
    //[AllowAnonymous]
    public class UplataController : BaseCRUDController<Model.Uplata, UplataSearchObject, UplataInsertRequest, UplateUpdateRequest>
    {
        public UplataController(ILogger<BaseController<Model.Uplata, UplataSearchObject>> logger, IUplataService service) : base(logger, service)
        {
        }
    }
}