using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eRestoran.Model.Requests
{
    public class DojmoviInsertRequest
    {
       // public int Id { get; set; }

        public int? Ocjena { get; set; }
        public string? Opis { get; set; }
        public int? JeloId { get; set; }
        public int? KorisnikId { get; set; }

     //   public virtual Jelo? Jelo { get; set; }

      //  public virtual Korisnik? Korisnik { get; set; }
    }
}
