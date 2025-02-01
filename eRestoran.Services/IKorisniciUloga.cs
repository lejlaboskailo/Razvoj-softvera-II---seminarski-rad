using eRestoran.Model.Requests;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eRestoran.Services
{
    public interface IKorisniciUloga : ICRUDService<Model.KorisniciUloge, Model.SearchObjects.KorisniciUlogaSearchRequest, KorisniciUlogeInsertRequest, KorisniciUlogeUpdateRequest>
    {

    }
}
