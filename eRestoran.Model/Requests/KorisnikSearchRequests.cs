using eRestoran.Model.SearchObjects;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eRestoran.Model.Requests
{
    public class KorisnikSearchRequests : BaseSearchObject
    { 
        public string ImePrezime { get; set; }
    }
}
