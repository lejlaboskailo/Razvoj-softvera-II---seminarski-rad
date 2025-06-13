using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace eRestoran.Services.Migrations
{
    /// <inheritdoc />
    public partial class DataInitial : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.UpdateData(
                table: "Korisnici",
                keyColumn: "Id",
                keyValue: 1001,
                columns: new[] { "LozinkaHash", "LozinkaSalt" },
                values: new object[] { "Fp2Hhe9CzFxwMlBBakEJvNSoq8c=", "RkDYB8BPuC+lgVSFZtDQyw==" });

            migrationBuilder.UpdateData(
                table: "Korisnici",
                keyColumn: "Id",
                keyValue: 1002,
                columns: new[] { "LozinkaHash", "LozinkaSalt" },
                values: new object[] { "Aa0IqwGS0glvs2LbGeWrOacDkU0=", "eurjWKSfEodMR4UQ3PCLTA==" });

            migrationBuilder.UpdateData(
                table: "Korisnici",
                keyColumn: "Id",
                keyValue: 1007,
                columns: new[] { "LozinkaHash", "LozinkaSalt" },
                values: new object[] { "sPf8ahtIDyxOuMFNrubGNxddgtg=", "cW9rMNhTd3gsQpTN7y4gPQ==" });

            migrationBuilder.UpdateData(
                table: "KorisniciUloge",
                keyColumn: "KorisnikUlogaId",
                keyValue: 1,
                column: "DatumIzmjene",
                value: new DateTime(2025, 6, 13, 11, 50, 26, 857, DateTimeKind.Local).AddTicks(404));

            migrationBuilder.UpdateData(
                table: "KorisniciUloge",
                keyColumn: "KorisnikUlogaId",
                keyValue: 2,
                column: "DatumIzmjene",
                value: new DateTime(2025, 6, 13, 11, 50, 26, 857, DateTimeKind.Local).AddTicks(449));

            migrationBuilder.UpdateData(
                table: "Narudzba",
                keyColumn: "Id",
                keyValue: 6000,
                column: "DatumNarudzbe",
                value: new DateTime(2025, 6, 13, 11, 50, 26, 857, DateTimeKind.Local).AddTicks(1096));
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.UpdateData(
                table: "Korisnici",
                keyColumn: "Id",
                keyValue: 1001,
                columns: new[] { "LozinkaHash", "LozinkaSalt" },
                values: new object[] { "BAilvsOBtjHNU0r+tCWRI2eUo+U=", "DKzCrfwnpY0qBZ3H7JQ0Jg==" });

            migrationBuilder.UpdateData(
                table: "Korisnici",
                keyColumn: "Id",
                keyValue: 1002,
                columns: new[] { "LozinkaHash", "LozinkaSalt" },
                values: new object[] { "ftuSgiiWzsQhgF/8fv9xVR1DaKA=", "afUn6JKjtH/yR867aVBMuw==" });

            migrationBuilder.UpdateData(
                table: "Korisnici",
                keyColumn: "Id",
                keyValue: 1007,
                columns: new[] { "LozinkaHash", "LozinkaSalt" },
                values: new object[] { "28PfvKK4Xzfv+RAkQzn1BEHf7iw=", "5EuB4s2+RQcKgDRgOknUCg==" });

            migrationBuilder.UpdateData(
                table: "KorisniciUloge",
                keyColumn: "KorisnikUlogaId",
                keyValue: 1,
                column: "DatumIzmjene",
                value: new DateTime(2025, 6, 13, 11, 44, 54, 646, DateTimeKind.Local).AddTicks(3452));

            migrationBuilder.UpdateData(
                table: "KorisniciUloge",
                keyColumn: "KorisnikUlogaId",
                keyValue: 2,
                column: "DatumIzmjene",
                value: new DateTime(2025, 6, 13, 11, 44, 54, 646, DateTimeKind.Local).AddTicks(3499));

            migrationBuilder.UpdateData(
                table: "Narudzba",
                keyColumn: "Id",
                keyValue: 6000,
                column: "DatumNarudzbe",
                value: new DateTime(2025, 6, 13, 11, 44, 54, 646, DateTimeKind.Local).AddTicks(4125));
        }
    }
}
