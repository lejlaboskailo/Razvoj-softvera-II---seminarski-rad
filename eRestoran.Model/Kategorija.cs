﻿using Microsoft.Identity.Client;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eRestoran.Model
{
    public class Kategorija
    {
        public int Id { get; set; }
        public string Naziv { get; set; }
        public string Opis { get; set; }
    }
}
