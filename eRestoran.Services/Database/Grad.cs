﻿using System;
using System.Collections.Generic;
using System.Diagnostics.Metrics;

namespace eRestoran.Services.Database;

public partial class Grad
{
    public int Id { get; set; }

    public string? Naziv { get; set; }

    public virtual ICollection<Korisnici> Korisnicis { get; set; } = new List<Korisnici>();
}
