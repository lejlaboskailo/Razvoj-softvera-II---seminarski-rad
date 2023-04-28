using System;
using System.Collections.Generic;

namespace eRestoran.Services.Database;

public partial class StavkeNarudzbe
{
    public int Id { get; set; }

    public int? Kolicina { get; set; }

    public int? Cijena { get; set; }

    public int? JeloId { get; set; }

    public int? NarudzbaId { get; set; }

    public virtual Jelo? Jelo { get; set; }

    public virtual Narudzba? Narudzba { get; set; }
}
