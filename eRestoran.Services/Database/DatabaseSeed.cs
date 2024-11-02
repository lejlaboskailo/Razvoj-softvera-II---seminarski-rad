using eRestoran.Model;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Threading.Tasks;

namespace eRestoran.Services.Database
{
    public static class Data
    {
        public static string GenerateSalt()
        {
            var buf = new byte[16];
            (new RNGCryptoServiceProvider()).GetBytes(buf);
            return Convert.ToBase64String(buf);
        }

        public static string GenerateHash(string salt, string password)
        {
            byte[] src = Convert.FromBase64String(salt);
            byte[] bytes = Encoding.Unicode.GetBytes(password);
            byte[] dst = new byte[src.Length + bytes.Length];
            System.Buffer.BlockCopy(src, 0, dst, 0, src.Length);
            System.Buffer.BlockCopy(bytes, 0, dst, src.Length, bytes.Length);
            HashAlgorithm algorithm = HashAlgorithm.Create("SHA1");
            byte[] inArray = algorithm.ComputeHash(dst);
            return Convert.ToBase64String(inArray);
        }

        public static void Seed(this ModelBuilder modelBuilder)
        {

            List<string> Salt = new List<string>();
            for (int i = 0; i < 5; i++)
            {
                Salt.Add(KorisniciService.GenerateSalt());
            }

            #region Dodavanje Korisnika

            Services.Database.Korisnici korisnik = new Services.Database.Korisnici()
            {
                Id = 1001,
                Ime = "Medzida",
                Prezime = "Bojcic",
                KorisnickoIme = "admin",
                LozinkaSalt = GenerateSalt(),
                LozinkaHash = GenerateHash(GenerateSalt(), "test"),
            };
            korisnik.LozinkaSalt = GenerateSalt();
            korisnik.LozinkaHash = GenerateHash(korisnik.LozinkaSalt, "test");
            modelBuilder.Entity<Korisnici>().HasData(korisnik);

            Services.Database.Korisnici korisnik2 = new Services.Database.Korisnici()
            {
                Id = 1002,
                Ime = "Ena",
                Prezime = "Bojcic",
                KorisnickoIme = "mobile",
                LozinkaSalt = GenerateSalt(),
                LozinkaHash = GenerateHash(GenerateSalt(), "test"),
            };
            korisnik2.LozinkaSalt = GenerateSalt();
            korisnik2.LozinkaHash = GenerateHash(korisnik2.LozinkaSalt, "test");
            modelBuilder.Entity<Korisnici>().HasData(korisnik2);

            #endregion

            #region Dodavanje Uloga

            modelBuilder.Entity<Uloge>().HasData(
                 new Uloge()
                 {
                     Id = 1,
                     Naziv = "Admin",
                     Opis = "Upravljanje sistemom"
                 },
                 new Uloge()
                 {
                     Id = 2,
                     Naziv = "Korisnik",
                     Opis = "Pregled podataka"
                 });
            #endregion

            #region Dodavanje KorisnikUloga

            modelBuilder.Entity<KorisniciUloge>().HasData(
                 new KorisniciUloge()
                 {
                     KorisnikUlogaId = 1,
                     KorisnikId = 1001,
                     UlogaId = 1,
                     DatumIzmjene = DateTime.Now,
                 },
                 new KorisniciUloge()
                 {
                     KorisnikUlogaId = 2,
                     KorisnikId = 1002,
                     UlogaId = 2,
                     DatumIzmjene = DateTime.Now,
                 });
            #endregion

            #region Dodavanje Drzava

            modelBuilder.Entity<Drzava>().HasData(
                 new Drzava()
                 {
                     Id = 2000,
                     Naziv = "Bosna i Hercegovina",
                 },
                 new Drzava()
                 {
                     Id = 2001,
                     Naziv = "Njemacka",
                 }
                 );
            #endregion

            #region Dodavanje Grad

            modelBuilder.Entity<Grad>().HasData(
                 new Drzava()
                 {
                     Id = 3000,
                     Naziv = "Sarajevo",
                 });
            #endregion

            #region Dodavanje Kategorija

            modelBuilder.Entity<Kategorija>().HasData(
                 new Kategorija()
                 {
                     Id = 4000,
                     Naziv = "Pizza",
                     Opis = "top"
                 },
                 new Kategorija()
                 {
                     Id = 4001,
                     Naziv = "Rostilj",
                     Opis = "top"
                 },
                 new Kategorija()
                 {
                     Id = 4002,
                     Naziv = "Pasta",
                     Opis = "top"
                 },
                 new Kategorija()
                 {
                     Id = 4003,
                     Naziv = "Desert",
                     Opis = "top"
                 }
                 );
            #endregion

            #region Dodavanje Meni

            modelBuilder.Entity<Jelo>().HasData(
                 new Jelo()
                 {
                     Id = 5000,
                     Naziv = "Margarita",
                     Opis = "top",
                     Cijena = 15,
                     KategorijaId = 4000
                 }
                 );
            #endregion

            #region Dodavanje StatusNarudzbe

            modelBuilder.Entity<Status>().HasData(
                 new Status()
                 {
                     Id = 8010,
                     Naziv = "poslano"
                 }
                 );
            #endregion

            #region Dodavanje Narudzba

            modelBuilder.Entity<Narudzba>().HasData(
                 new Narudzba()
                 {
                     Id = 6000,
                     DatumNarudzbe = DateTime.Now,
                     StatusNarudzbeId = 8010,
                     KorisnikId = 1001,
                     StateMachine = "poslano"
                 }
                 );
            #endregion

            #region Dodavanje NarudzbaStavke

            modelBuilder.Entity<StavkeNarudzbe>().HasData(
                 new StavkeNarudzbe()
                 {
                     Id = 7000,
                     Kolicina = 2,
                     Cijena = 30,
                     JeloId = 5000,
                     NarudzbaId = 6000,
                 }
                 );
            #endregion

            #region Dodavanje Recenzije

            modelBuilder.Entity<Dojmovi>().HasData(
                 new Dojmovi()
                 {
                     Id = 8000,
                     Ocjena = 5,
                     Opis = "odlicna dostava",
                     JeloId = 5000,
                     KorisnikId = 1002,
                 }
                 );
            #endregion

           

        }
    }
}
