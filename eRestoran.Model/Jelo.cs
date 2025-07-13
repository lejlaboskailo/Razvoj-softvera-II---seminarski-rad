
using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Text.Json.Serialization;
using System.Threading.Tasks;

namespace eRestoran.Model
{
    public class Jelo
    {
        public int JeloId { get; set; }
        public string Naziv { get; set; }
        public string Opis { get; set; }
        public decimal Cijena { get; set; }
        public int KategorijaId { get; set; }
       // public Kategorija Kategorija { get; set; }
       public byte[]? Slika { get; set; }
        public string? StateMachine { get; set; }

        //public byte[]? SlikaThumb { get; set; }
    }
}
    
