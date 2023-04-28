using System;
using System.Collections.Generic;

namespace eRestoran.Services.Database;

public partial class Dojmovi
{
    public int Id { get; set; }

    public int? Ocjena { get; set; }

    public string? Opis { get; set; }

    public int? JeloId { get; set; }

    public int? KorisnikId { get; set; }

    public virtual Jelo? Jelo { get; set; }

    public virtual Korisnici? Korisnik { get; set; }
}
