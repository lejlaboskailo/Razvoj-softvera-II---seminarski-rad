using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

#pragma warning disable CA1814 // Prefer jagged arrays over multidimensional

namespace eRestoran.Services.Migrations
{
    /// <inheritdoc />
    public partial class AddJeloSeed : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.InsertData(
                table: "Jelo",
                columns: new[] { "Id", "Cijena", "KategorijaId", "Naziv", "Opis", "Slika" },
                values: new object[,]
                {
                    { 5001, 15m, 4000, "Funghi", "top", null },
                    { 5002, 15m, 4003, "Cheesecake", "top", null },
                    { 5004, 15m, 4001, "Cevapi", "top", null },
                    { 5005, 15m, 4002, "Makaroni", "top", null }
                });

            migrationBuilder.UpdateData(
                table: "Korisnici",
                keyColumn: "Id",
                keyValue: 1001,
                columns: new[] { "LozinkaHash", "LozinkaSalt" },
                values: new object[] { "o//v9wSbzMmf46L7Npc6GGDaGVk=", "eGndTzHmiUshN3gV3EUydw==" });

            migrationBuilder.UpdateData(
                table: "Korisnici",
                keyColumn: "Id",
                keyValue: 1002,
                columns: new[] { "LozinkaHash", "LozinkaSalt" },
                values: new object[] { "lts/Nv1B7rr/ekBYiRuixNIqkWw=", "63YJmhqjNaoamFxYQ8/tmA==" });

            migrationBuilder.UpdateData(
                table: "Korisnici",
                keyColumn: "Id",
                keyValue: 1007,
                columns: new[] { "LozinkaHash", "LozinkaSalt" },
                values: new object[] { "nX11+0kLbehu11elVVP0+aUFzjM=", "hrw+nu41h7CKybg1VbkmvQ==" });

            migrationBuilder.UpdateData(
                table: "KorisniciUloge",
                keyColumn: "KorisnikUlogaId",
                keyValue: 1,
                column: "DatumIzmjene",
                value: new DateTime(2025, 1, 20, 13, 36, 28, 421, DateTimeKind.Local).AddTicks(2272));

            migrationBuilder.UpdateData(
                table: "KorisniciUloge",
                keyColumn: "KorisnikUlogaId",
                keyValue: 2,
                column: "DatumIzmjene",
                value: new DateTime(2025, 1, 20, 13, 36, 28, 421, DateTimeKind.Local).AddTicks(2316));

            migrationBuilder.UpdateData(
                table: "Narudzba",
                keyColumn: "Id",
                keyValue: 6000,
                column: "DatumNarudzbe",
                value: new DateTime(2025, 1, 20, 13, 36, 28, 421, DateTimeKind.Local).AddTicks(3031));
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DeleteData(
                table: "Jelo",
                keyColumn: "Id",
                keyValue: 5001);

            migrationBuilder.DeleteData(
                table: "Jelo",
                keyColumn: "Id",
                keyValue: 5002);

            migrationBuilder.DeleteData(
                table: "Jelo",
                keyColumn: "Id",
                keyValue: 5004);

            migrationBuilder.DeleteData(
                table: "Jelo",
                keyColumn: "Id",
                keyValue: 5005);

            migrationBuilder.UpdateData(
                table: "Korisnici",
                keyColumn: "Id",
                keyValue: 1001,
                columns: new[] { "LozinkaHash", "LozinkaSalt" },
                values: new object[] { "uWYqS1fpg+eNnJzJQwwxcKno35I=", "E+lIX07uCbrUhUoKkFdULw==" });

            migrationBuilder.UpdateData(
                table: "Korisnici",
                keyColumn: "Id",
                keyValue: 1002,
                columns: new[] { "LozinkaHash", "LozinkaSalt" },
                values: new object[] { "Yx6T6rEQPT+U8704xTIA6L2njUY=", "RoH+566s/mrzK+9a5qTRVg==" });

            migrationBuilder.UpdateData(
                table: "Korisnici",
                keyColumn: "Id",
                keyValue: 1007,
                columns: new[] { "LozinkaHash", "LozinkaSalt" },
                values: new object[] { "9FbPOvtpMe86Dgf3yuSRusRh76c=", "G/fqHCuB3Dx3wBfmJL7LTA==" });

            migrationBuilder.UpdateData(
                table: "KorisniciUloge",
                keyColumn: "KorisnikUlogaId",
                keyValue: 1,
                column: "DatumIzmjene",
                value: new DateTime(2024, 12, 30, 18, 22, 56, 726, DateTimeKind.Local).AddTicks(1230));

            migrationBuilder.UpdateData(
                table: "KorisniciUloge",
                keyColumn: "KorisnikUlogaId",
                keyValue: 2,
                column: "DatumIzmjene",
                value: new DateTime(2024, 12, 30, 18, 22, 56, 726, DateTimeKind.Local).AddTicks(1283));

            migrationBuilder.UpdateData(
                table: "Narudzba",
                keyColumn: "Id",
                keyValue: 6000,
                column: "DatumNarudzbe",
                value: new DateTime(2024, 12, 30, 18, 22, 56, 726, DateTimeKind.Local).AddTicks(2065));
        }
    }
}
