using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eRestoran.Model.Requests
{
    public class KorisnikUpsertRequest
    {
        //public int Id { get; set; }
        public string Ime { get; set; }
        public string Prezime { get; set; }
        public string KorisnickoIme { get; set; }

        [Required(ErrorMessage ="Password is required")]
        public string Lozinka { get; set; }
      //  public int DrzavaId { get; set; }
      //  public int GradId { get; set; }
    }
}
