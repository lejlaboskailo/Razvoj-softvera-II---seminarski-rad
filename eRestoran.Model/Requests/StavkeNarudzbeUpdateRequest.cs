using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eRestoran.Model.Requests
{
    public class StavkeNarudzbeUpdateRequest
    {
        //public int Id { get; set; }
        public int? Kolicina { get; set; }
        public int? Cijena { get; set; }
        public int? JeloId { get; set; }
        public int? NarudzbaId { get; set; }
       // public virtual Jelo? Jelo { get; set; }
       // public virtual Narudzba? Narudzba { get; set; }
    }
}
