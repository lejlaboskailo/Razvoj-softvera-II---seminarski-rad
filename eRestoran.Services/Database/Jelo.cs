using System;
using System.Collections.Generic;

namespace eRestoran.Services.Database;

public partial class Jelo
{
    public int Id { get; set; }

    public string? Naziv { get; set; }

    public string? Opis { get; set; }

    public decimal? Cijena { get; set; }

    public int? KategorijaId { get; set; }

    public string? Slika { get; set; }

    public virtual ICollection<Dojmovi> Dojmovis { get; set; } = new List<Dojmovi>();

    public virtual Kategorija? Kategorija { get; set; }

    public virtual ICollection<StavkeNarudzbe> StavkeNarudzbes { get; set; } = new List<StavkeNarudzbe>();
}
