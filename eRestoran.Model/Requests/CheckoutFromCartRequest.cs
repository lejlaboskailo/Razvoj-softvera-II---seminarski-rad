using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eRestoran.Model.Requests
{
    public class CheckoutFromCartRequest
    {
        public int KorisnikId { get; set; }
        public int? StatusId { get; set; } = 1;   
        public string? PaymentId { get; set; }
        public DateTime? DatumNarudzbe { get; set; }

    }
}
