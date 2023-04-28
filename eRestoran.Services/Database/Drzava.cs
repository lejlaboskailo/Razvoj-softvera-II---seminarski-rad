using System;
using System.Collections.Generic;

namespace eRestoran.Services.Database;

public partial class Drzava
{
    public int Id { get; set; }

    public string? Naziv { get; set; }

    public virtual ICollection<Korisnici> Korisnicis { get; set; } = new List<Korisnici>();
}
