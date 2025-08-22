using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eRestoran.Model.Requests
{
    public class NarudzbaCheckoutStavkaRequest
    {
        public int JeloId { get; set; }
        public int Kolicina { get; set; }
    }
}
