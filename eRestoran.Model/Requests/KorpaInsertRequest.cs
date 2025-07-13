using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eRestoran.Model.Requests
{
    public class KorpaInsertRequest
    {
     //   public int KorpaId { get; set; }
        public int JeloId { get; set; }
        public int KorisnikId { get; set; }
        public decimal? Cijena { get; set; }
        public int? KategorijaId { get; set; }
        public int? Kolicina { get; set; }
    }
}
