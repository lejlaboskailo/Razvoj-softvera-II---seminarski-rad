using eRestoran.Model.Requests;
using eRestoran.Model.SearchObjects;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eRestoran.Services
{
    public interface IDrzavaService : ICRUDService<Model.Drzava, DrzavaSearchObject, DrzavaUpsertRequest,DrzavaUpsertRequest>
    {
    }
}
