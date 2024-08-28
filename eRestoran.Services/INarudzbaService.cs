using eRestoran.Model;
using eRestoran.Model.Requests;
using eRestoran.Model.SearchObjects;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eRestoran.Services
{
    public interface INarudzbaService : ICRUDService<Model.Narudzba, NarudzbaSearchObject, NarudzbaUpsertRequest, NarudzbaUpsertRequest>
    {
       /* List<Model.Narudzba> Get(NarudzbaSearchObject search);
        Task<Model.Narudzba> UpdateAsync(int id, NarudzbaUpsertRequest request);

        Task<List<string>> AllowedActions(int id);
        Task<Narudzba> Accept(int id);
        Task<Narudzba> InProgress(int id);
        Task<Narudzba> Finish(int id);
        Task<Narudzba> Deliver(int id);
        Task<Narudzba> Cancel(int id);*/
    }
}
