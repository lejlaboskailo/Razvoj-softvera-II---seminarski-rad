using eRestoran.Model.Requests;
using eRestoran.Model.SearchObjects;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eRestoran.Services
{
    public interface IStavkeNrudzbeService:ICRUDService<Model.StavkeNarudzbe,StavkeNarudzbeSearchObject,StavkeNarudzbeInsertRequest,StavkeNarudzbeUpdateRequest>
    {
        //Task<List<Model.StavkeNarudzbe>> InsertAsync(List<StavkeNarudzbeUpsertRequest> request);
    }
}
