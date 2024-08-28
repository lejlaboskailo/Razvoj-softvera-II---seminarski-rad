using eRestoran.Model;
using eRestoran.Model.Requests;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eRestoran.Services
{
    public interface IKorisniciService:ICRUDService<Korisnik,KorisnikSearchRequests,KorisnikUpsertRequest,KorisnikUpsertRequest>
    {
        Task<Model.Korisnik> InsertAsync(KorisnikUpsertRequest korisnici);
        Task<Model.Korisnik> Login(string username, string password);
    }
}
