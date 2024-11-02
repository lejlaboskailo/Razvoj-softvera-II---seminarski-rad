using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eRestoran.Model.Requests
{
    public class NarudzbaUpdateRequest
    {
        // public int Id { get; set; }
        public DateTime DatumNarudzbe { get; set; }
        public int KorisnikId { get; set; }
        // public string Korisnik { get; set; }
        public int StatusNarudzbeId { get; set; }
        //public string StatusNarudzbe { get; set; }
        // public string? StateMachine { get; set; }
    }
}
