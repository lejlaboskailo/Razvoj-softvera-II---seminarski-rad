using System;
using System.Collections.Generic;

namespace eRestoran.Services.Database;

public partial class Uplatum
{
    public int Id { get; set; }

    public decimal? Iznos { get; set; }

    public DateTime? DatumTransakcije { get; set; }

    public string? BrojTransakcije { get; set; }

    public int? KorisnikId { get; set; }

    public virtual Korisnici? Korisnik { get; set; }
}
