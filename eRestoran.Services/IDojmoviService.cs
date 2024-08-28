using eRestoran.Model.Requests;
using eRestoran.Model.SearchObjects;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eRestoran.Services
{
    public interface IDojmoviService : ICRUDService<Model.Dojmovi,DojmoviSearchObject,DojmoviUpsertRequest, DojmoviUpsertRequest>
    {

    }
}
