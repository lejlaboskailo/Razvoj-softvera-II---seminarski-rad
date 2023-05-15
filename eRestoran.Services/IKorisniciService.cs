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
        IList<Model.Korisnik> GetAll(/*KorisnikSearchRequest search*/);
        Model.Korisnik GetById(int id);
        Task<Model.Korisnik> InsertAsync(KorisnikUpsertRequest korisnici);
        Task<Model.Korisnik> UpdateAsync(int id, KorisnikUpsertRequest korisnici);
        Task<Model.Korisnik> Login(string username, string password);
    }
}
