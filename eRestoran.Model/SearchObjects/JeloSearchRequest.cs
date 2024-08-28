using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eRestoran.Model.SearchObjects
{
    public class JeloSearchObject : BaseSearchObject
    {
       // public int KategorijaId { get; set; }
        public string Naziv { get; set; }
        public string? KategorijaNaziv {  get; set; }
    }
}
