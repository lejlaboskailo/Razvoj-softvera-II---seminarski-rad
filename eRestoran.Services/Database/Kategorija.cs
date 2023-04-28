using System;
using System.Collections.Generic;

namespace eRestoran.Services.Database;

public partial class Kategorija
{
    public int Id { get; set; }

    public string? Naziv { get; set; }

    public string? Opis { get; set; }

    public virtual ICollection<Jelo> Jelos { get; set; } = new List<Jelo>();
}
