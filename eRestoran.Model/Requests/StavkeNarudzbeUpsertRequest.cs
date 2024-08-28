using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eRestoran.Model.Requests
{
    public class StavkeNarudzbeUpsertRequest
    {
        public int Kolicina { get; set; }

        [Range(0,double.MaxValue)]
        public int Cijena { get; set; }
        public int JeloId { get; set; }
       // public Jelo Jelo { get; set; }
        public int NarudzbaId { get; set; }
    }
}
