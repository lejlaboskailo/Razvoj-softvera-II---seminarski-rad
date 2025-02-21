using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace eRestoran.Services.Migrations
{
    /// <inheritdoc />
    public partial class dodajStateMAchinee : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.UpdateData(
                table: "Dojmovi",
                keyColumn: "Id",
                keyValue: 9116,
                column: "KorisnikId",
                value: 1001);

            migrationBuilder.UpdateData(
                table: "Korisnici",
                keyColumn: "Id",
                keyValue: 1001,
                columns: new[] { "LozinkaHash", "LozinkaSalt" },
                values: new object[] { "9AlMf9iZUdStXIY3B5uy9nWuL1s=", "TVksIssJ6X4mVDCWEf4yQQ==" });

            migrationBuilder.UpdateData(
                table: "Korisnici",
                keyColumn: "Id",
                keyValue: 1002,
                columns: new[] { "LozinkaHash", "LozinkaSalt" },
                values: new object[] { "0yuhB1OIUTJVWU5npmA2kBt72Rw=", "NevjmxOeVToe7eGO3ARKHg==" });

            migrationBuilder.UpdateData(
                table: "Korisnici",
                keyColumn: "Id",
                keyValue: 1007,
                columns: new[] { "LozinkaHash", "LozinkaSalt" },
                values: new object[] { "5BQYTPKtYoWRolSg1mh50DVzL8Q=", "WM7On9Z8rmjzphhzeBtpeA==" });

            migrationBuilder.UpdateData(
                table: "KorisniciUloge",
                keyColumn: "KorisnikUlogaId",
                keyValue: 1,
                column: "DatumIzmjene",
                value: new DateTime(2025, 2, 21, 17, 57, 0, 576, DateTimeKind.Local).AddTicks(1921));

            migrationBuilder.UpdateData(
                table: "KorisniciUloge",
                keyColumn: "KorisnikUlogaId",
                keyValue: 2,
                column: "DatumIzmjene",
                value: new DateTime(2025, 2, 21, 17, 57, 0, 576, DateTimeKind.Local).AddTicks(1967));

            migrationBuilder.UpdateData(
                table: "Narudzba",
                keyColumn: "Id",
                keyValue: 6000,
                column: "DatumNarudzbe",
                value: new DateTime(2025, 2, 21, 17, 57, 0, 576, DateTimeKind.Local).AddTicks(2642));
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.UpdateData(
                table: "Dojmovi",
                keyColumn: "Id",
                keyValue: 9116,
                column: "KorisnikId",
                value: 1007);

            migrationBuilder.UpdateData(
                table: "Korisnici",
                keyColumn: "Id",
                keyValue: 1001,
                columns: new[] { "LozinkaHash", "LozinkaSalt" },
                values: new object[] { "pj/iypkCO9FHQTwcVcxx8ClG1mc=", "n6zW0GErZz33JfWjaIOhJQ==" });

            migrationBuilder.UpdateData(
                table: "Korisnici",
                keyColumn: "Id",
                keyValue: 1002,
                columns: new[] { "LozinkaHash", "LozinkaSalt" },
                values: new object[] { "/WgnJm0mG17VwtA2It0U+zUWDMo=", "iAWP0prz+L3MgCdG6gkx2g==" });

            migrationBuilder.UpdateData(
                table: "Korisnici",
                keyColumn: "Id",
                keyValue: 1007,
                columns: new[] { "LozinkaHash", "LozinkaSalt" },
                values: new object[] { "8Ec3586vDuXMJ0NW/DYEf9x4mWg=", "ec4+LbH2r12iQxShvsSHzA==" });

            migrationBuilder.UpdateData(
                table: "KorisniciUloge",
                keyColumn: "KorisnikUlogaId",
                keyValue: 1,
                column: "DatumIzmjene",
                value: new DateTime(2025, 2, 21, 17, 54, 15, 788, DateTimeKind.Local).AddTicks(838));

            migrationBuilder.UpdateData(
                table: "KorisniciUloge",
                keyColumn: "KorisnikUlogaId",
                keyValue: 2,
                column: "DatumIzmjene",
                value: new DateTime(2025, 2, 21, 17, 54, 15, 788, DateTimeKind.Local).AddTicks(886));

            migrationBuilder.UpdateData(
                table: "Narudzba",
                keyColumn: "Id",
                keyValue: 6000,
                column: "DatumNarudzbe",
                value: new DateTime(2025, 2, 21, 17, 54, 15, 788, DateTimeKind.Local).AddTicks(1540));
        }
    }
}
