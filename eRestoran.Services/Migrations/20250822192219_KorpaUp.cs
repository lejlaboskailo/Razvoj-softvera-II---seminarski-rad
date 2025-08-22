using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace eRestoran.Services.Migrations
{
    /// <inheritdoc />
    public partial class KorpaUp : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.UpdateData(
                table: "Korisnici",
                keyColumn: "Id",
                keyValue: 1001,
                columns: new[] { "LozinkaHash", "LozinkaSalt" },
                values: new object[] { "VIF6Ogc7dsnbA+VwY2Z9P4LvWBo=", "hwt0Oo+hTwEdxKYwi3ZSRQ==" });

            migrationBuilder.UpdateData(
                table: "Korisnici",
                keyColumn: "Id",
                keyValue: 1002,
                columns: new[] { "LozinkaHash", "LozinkaSalt" },
                values: new object[] { "SsWiVjJg7rkF67RSrQm596KOYUA=", "qi7ZjnG0GrkzAROoCLOzKw==" });

            migrationBuilder.UpdateData(
                table: "Korisnici",
                keyColumn: "Id",
                keyValue: 1007,
                columns: new[] { "LozinkaHash", "LozinkaSalt" },
                values: new object[] { "K5y4NHl4ZJZXSSrNM5VGzLiu5sk=", "DZ0pLZ1w8wMogxDGe3x56g==" });

            migrationBuilder.UpdateData(
                table: "KorisniciUloge",
                keyColumn: "KorisnikUlogaId",
                keyValue: 1,
                column: "DatumIzmjene",
                value: new DateTime(2025, 8, 22, 21, 22, 18, 889, DateTimeKind.Local).AddTicks(7003));

            migrationBuilder.UpdateData(
                table: "KorisniciUloge",
                keyColumn: "KorisnikUlogaId",
                keyValue: 2,
                column: "DatumIzmjene",
                value: new DateTime(2025, 8, 22, 21, 22, 18, 889, DateTimeKind.Local).AddTicks(7139));

            migrationBuilder.UpdateData(
                table: "Korpa",
                keyColumn: "KorpaId",
                keyValue: 7898,
                column: "PrilogId",
                value: 4898);

            migrationBuilder.UpdateData(
                table: "Narudzba",
                keyColumn: "Id",
                keyValue: 6000,
                column: "DatumNarudzbe",
                value: new DateTime(2025, 8, 22, 21, 22, 18, 889, DateTimeKind.Local).AddTicks(7881));
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.UpdateData(
                table: "Korisnici",
                keyColumn: "Id",
                keyValue: 1001,
                columns: new[] { "LozinkaHash", "LozinkaSalt" },
                values: new object[] { "SqiPllYB9Z2RdP0gL4/OWLCwYrU=", "GTncutrDS+BZxBEUVcK55A==" });

            migrationBuilder.UpdateData(
                table: "Korisnici",
                keyColumn: "Id",
                keyValue: 1002,
                columns: new[] { "LozinkaHash", "LozinkaSalt" },
                values: new object[] { "HpDgDZH5zZHJP7LrijAjlDkcaDE=", "wm9yqPvQMiqo4mGGtVNyAA==" });

            migrationBuilder.UpdateData(
                table: "Korisnici",
                keyColumn: "Id",
                keyValue: 1007,
                columns: new[] { "LozinkaHash", "LozinkaSalt" },
                values: new object[] { "79gLCwYrfLmHZhZ8l5LSlAYK3Jg=", "bertlW75J+p2zYolA7FwXQ==" });

            migrationBuilder.UpdateData(
                table: "KorisniciUloge",
                keyColumn: "KorisnikUlogaId",
                keyValue: 1,
                column: "DatumIzmjene",
                value: new DateTime(2025, 8, 22, 21, 21, 2, 497, DateTimeKind.Local).AddTicks(8343));

            migrationBuilder.UpdateData(
                table: "KorisniciUloge",
                keyColumn: "KorisnikUlogaId",
                keyValue: 2,
                column: "DatumIzmjene",
                value: new DateTime(2025, 8, 22, 21, 21, 2, 497, DateTimeKind.Local).AddTicks(8390));

            migrationBuilder.UpdateData(
                table: "Korpa",
                keyColumn: "KorpaId",
                keyValue: 7898,
                column: "PrilogId",
                value: null);

            migrationBuilder.UpdateData(
                table: "Narudzba",
                keyColumn: "Id",
                keyValue: 6000,
                column: "DatumNarudzbe",
                value: new DateTime(2025, 8, 22, 21, 21, 2, 497, DateTimeKind.Local).AddTicks(8980));
        }
    }
}
