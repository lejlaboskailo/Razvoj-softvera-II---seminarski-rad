using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eRestoran.Model.Requests
{
    public class KorisniciUlogeInsertRequest
    {
        public int? KorisniciUlogaId { get;set; }
        public int? UlogaId { get; set; }
        public int? KorisnikId { get; set; }
        public DateTime? DatumIzmjene { get; set; }
    }
}
