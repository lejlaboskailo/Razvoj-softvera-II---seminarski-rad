using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace eRestoran.Services.Migrations
{
    /// <inheritdoc />
    public partial class UpdatedKorisnik : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DeleteData(
                table: "Korisnici",
                keyColumn: "Id",
                keyValue: 1007);

            migrationBuilder.UpdateData(
                table: "Korisnici",
                keyColumn: "Id",
                keyValue: 1001,
                columns: new[] { "Email", "Ime", "LozinkaHash", "LozinkaSalt", "Prezime" },
                values: new object[] { "lejla@gmail.com", "Lejla", "4YMX48dFwkPHZqCdEU2EGMPi89w=", "su5aXN1J+xiUv6P3Fe0Zzw==", "Boskailo" });

            migrationBuilder.UpdateData(
                table: "Korisnici",
                keyColumn: "Id",
                keyValue: 1002,
                columns: new[] { "Email", "Ime", "LozinkaHash", "LozinkaSalt", "Prezime" },
                values: new object[] { "elma@gmail.com", "Elma", "3wx6xYfyNi7HndSFgImYfmKMuaY=", "Ro9poIclNlY+9NOueGLQew==", "Kapic" });

            migrationBuilder.UpdateData(
                table: "KorisniciUloge",
                keyColumn: "KorisnikUlogaId",
                keyValue: 1,
                column: "DatumIzmjene",
                value: new DateTime(2025, 2, 1, 12, 44, 33, 131, DateTimeKind.Local).AddTicks(1592));

            migrationBuilder.UpdateData(
                table: "KorisniciUloge",
                keyColumn: "KorisnikUlogaId",
                keyValue: 2,
                column: "DatumIzmjene",
                value: new DateTime(2025, 2, 1, 12, 44, 33, 131, DateTimeKind.Local).AddTicks(1641));

            migrationBuilder.UpdateData(
                table: "Narudzba",
                keyColumn: "Id",
                keyValue: 6000,
                column: "DatumNarudzbe",
                value: new DateTime(2025, 2, 1, 12, 44, 33, 131, DateTimeKind.Local).AddTicks(2268));
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.UpdateData(
                table: "Korisnici",
                keyColumn: "Id",
                keyValue: 1001,
                columns: new[] { "Email", "Ime", "LozinkaHash", "LozinkaSalt", "Prezime" },
                values: new object[] { "medzida@gmail.com", "Medzida", "lTWpvsjfuwMZMehqkzgjHPxvBl8=", "a61Mdb80idWHRwAx8NpXSg==", "Bojcic" });

            migrationBuilder.UpdateData(
                table: "Korisnici",
                keyColumn: "Id",
                keyValue: 1002,
                columns: new[] { "Email", "Ime", "LozinkaHash", "LozinkaSalt", "Prezime" },
                values: new object[] { "ena@gmail.com", "Ena", "SbROkw6mA2O9TyBLeQ4VkXxfW0E=", "EvDmkUmlUA4XVaphUD3fOA==", "Bojcic" });

            migrationBuilder.InsertData(
                table: "Korisnici",
                columns: new[] { "Id", "DrzavaId", "Email", "GradId", "Ime", "KorisnickoIme", "LozinkaHash", "LozinkaSalt", "Prezime", "Telefon" },
                values: new object[] { 1007, null, "lejla@gmail.com", null, "Lejla", "korisnik", "j9XzxSJhWy5qnu4lhGqEHzcQYb8=", "5DaQwla5EPPPLgokthLH5Q==", "Boskailo", "066455778" });

            migrationBuilder.UpdateData(
                table: "KorisniciUloge",
                keyColumn: "KorisnikUlogaId",
                keyValue: 1,
                column: "DatumIzmjene",
                value: new DateTime(2025, 2, 1, 11, 57, 53, 32, DateTimeKind.Local).AddTicks(7057));

            migrationBuilder.UpdateData(
                table: "KorisniciUloge",
                keyColumn: "KorisnikUlogaId",
                keyValue: 2,
                column: "DatumIzmjene",
                value: new DateTime(2025, 2, 1, 11, 57, 53, 32, DateTimeKind.Local).AddTicks(7100));

            migrationBuilder.UpdateData(
                table: "Narudzba",
                keyColumn: "Id",
                keyValue: 6000,
                column: "DatumNarudzbe",
                value: new DateTime(2025, 2, 1, 11, 57, 53, 32, DateTimeKind.Local).AddTicks(7676));
        }
    }
}
