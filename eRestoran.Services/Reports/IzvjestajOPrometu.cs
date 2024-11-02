using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eRestoran.Services.Reports
{
    public class IzvjestajOPrometu
    {
        public decimal UkupniPromet { get; set; }
        public List<ProdajaPoKorisniku> ProdajaPoKorisniku { get; set; }
    }
}
