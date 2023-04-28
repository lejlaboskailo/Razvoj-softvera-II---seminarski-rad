using System;
using System.Collections.Generic;

namespace eRestoran.Services.Database;

public partial class Narudzba
{
    public int Id { get; set; }

    public DateTime? DatumNarudzbe { get; set; }

    public int? KorisnikId { get; set; }

    public int? StatusNarudzbeId { get; set; }

    public virtual Korisnici? Korisnik { get; set; }

    public virtual Status? StatusNarudzbe { get; set; }

    public virtual ICollection<StavkeNarudzbe> StavkeNarudzbes { get; set; } = new List<StavkeNarudzbe>();
}
