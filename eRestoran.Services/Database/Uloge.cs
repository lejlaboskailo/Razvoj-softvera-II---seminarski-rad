using System;
using System.Collections.Generic;

namespace eRestoran.Services.Database;

public partial class Uloge
{
    public int Id { get; set; }

    public string? Naziv { get; set; }

    public string? Opis { get; set; }

    public virtual ICollection<KorisniciUloge> KorisniciUloges { get; set; } = new List<KorisniciUloge>();
}
