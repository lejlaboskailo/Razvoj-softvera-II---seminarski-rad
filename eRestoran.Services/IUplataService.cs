using eRestoran.Model.Requests;
using eRestoran.Services;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;



namespace eRestoran.Services
{
    public interface IUplataService : ICRUDService<Model.Uplata, UplataSearchObject, UplataUpsertRequest, UplataUpsertRequest>
    {
    }
}