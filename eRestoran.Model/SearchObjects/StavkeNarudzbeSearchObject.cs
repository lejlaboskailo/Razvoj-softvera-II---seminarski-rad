using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eRestoran.Model.SearchObjects
{
    public class StavkeNarudzbeSearchObject:BaseSearchObject
    {
        public int JeloId { get; set; }
        public int NarudzbaId { get; set; }
        public int KorisnikId { get; set; }
    }
}
