using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace eRestoran.Services.Migrations
{
    /// <inheritdoc />
    public partial class dodaj : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.UpdateData(
                table: "Korisnici",
                keyColumn: "Id",
                keyValue: 1001,
                columns: new[] { "Email", "Ime", "LozinkaHash", "LozinkaSalt", "Prezime" },
                values: new object[] { "medzida@gmail.com", "Medzida", "4hXRRGrFRfXjFPFQ6ODqhCkSJ0g=", "FeO2//J50iQXuRUvZWY4Ew==", "Bojcic" });

            migrationBuilder.UpdateData(
                table: "Korisnici",
                keyColumn: "Id",
                keyValue: 1002,
                columns: new[] { "Email", "Ime", "LozinkaHash", "LozinkaSalt", "Prezime" },
                values: new object[] { "ena@gmail.com", "Ena", "+w6mSF+VonFRxLtrr8E8jgE5VhM=", "7WyGopQsJVSDIC6xGb1UjA==", "Bojcic" });

            migrationBuilder.UpdateData(
                table: "Korisnici",
                keyColumn: "Id",
                keyValue: 1007,
                columns: new[] { "Email", "Ime", "LozinkaHash", "LozinkaSalt" },
                values: new object[] { "lejla@gmail.com", "Lejla", "a6NL3QkbvZKTScUZsy4tZ5ikY5I=", "FL7CXrJXjt6O0AkDfR27Hg==" });

            migrationBuilder.UpdateData(
                table: "KorisniciUloge",
                keyColumn: "KorisnikUlogaId",
                keyValue: 1,
                column: "DatumIzmjene",
                value: new DateTime(2025, 2, 21, 16, 38, 32, 218, DateTimeKind.Local).AddTicks(6655));

            migrationBuilder.UpdateData(
                table: "KorisniciUloge",
                keyColumn: "KorisnikUlogaId",
                keyValue: 2,
                column: "DatumIzmjene",
                value: new DateTime(2025, 2, 21, 16, 38, 32, 218, DateTimeKind.Local).AddTicks(6702));

            migrationBuilder.UpdateData(
                table: "Narudzba",
                keyColumn: "Id",
                keyValue: 6000,
                column: "DatumNarudzbe",
                value: new DateTime(2025, 2, 21, 16, 38, 32, 218, DateTimeKind.Local).AddTicks(7373));
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.UpdateData(
                table: "Korisnici",
                keyColumn: "Id",
                keyValue: 1001,
                columns: new[] { "Email", "Ime", "LozinkaHash", "LozinkaSalt", "Prezime" },
                values: new object[] { "lejla@gmail.com", "Lejla", "Xw1lDKIFvuAtYC0ZzPWaEEPjSJY=", "NmPdd4k6+kdh9H16cFWVMQ==", "Boskailo" });

            migrationBuilder.UpdateData(
                table: "Korisnici",
                keyColumn: "Id",
                keyValue: 1002,
                columns: new[] { "Email", "Ime", "LozinkaHash", "LozinkaSalt", "Prezime" },
                values: new object[] { "elma@gmail.com", "Elma", "NEXh/uHL8j0FaozwuiyD+mK9kOI=", "tR/P1KBRLbibkrN8ldIt7A==", "Kapic" });

            migrationBuilder.UpdateData(
                table: "Korisnici",
                keyColumn: "Id",
                keyValue: 1007,
                columns: new[] { "Email", "Ime", "LozinkaHash", "LozinkaSalt" },
                values: new object[] { "heris@gmail.com", "Haris", "ZUfd5R6bBrxupDVGSVk41mfMPTI=", "Pyo1YWEAOEGd6I+xwhe9+A==" });

            migrationBuilder.UpdateData(
                table: "KorisniciUloge",
                keyColumn: "KorisnikUlogaId",
                keyValue: 1,
                column: "DatumIzmjene",
                value: new DateTime(2025, 2, 1, 12, 45, 41, 273, DateTimeKind.Local).AddTicks(3837));

            migrationBuilder.UpdateData(
                table: "KorisniciUloge",
                keyColumn: "KorisnikUlogaId",
                keyValue: 2,
                column: "DatumIzmjene",
                value: new DateTime(2025, 2, 1, 12, 45, 41, 273, DateTimeKind.Local).AddTicks(3881));

            migrationBuilder.UpdateData(
                table: "Narudzba",
                keyColumn: "Id",
                keyValue: 6000,
                column: "DatumNarudzbe",
                value: new DateTime(2025, 2, 1, 12, 45, 41, 273, DateTimeKind.Local).AddTicks(4415));
        }
    }
}
