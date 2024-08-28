using eRestoran.Model.Requests;
using eRestoran.Model.SearchObjects;
using eRestoran.Services;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Components;

namespace eRestoran.Controllers
{
    [Route("[controller]")]
    [AllowAnonymous]
    public class StavkeNarudzbeController:BaseCRUDController<Model.StavkeNarudzbe,StavkeNarudzbeSearchObject,StavkeNarudzbeUpsertRequest,StavkeNarudzbeUpsertRequest>
    {
        public StavkeNarudzbeController(ILogger<BaseController<Model.StavkeNarudzbe, StavkeNarudzbeSearchObject>> logger, IStavkeNrudzbeService service) : base(logger, service)
        {
        }
    }
}
