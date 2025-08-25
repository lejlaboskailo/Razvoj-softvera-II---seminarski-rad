using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace eRestoran.Services.Migrations
{
    /// <inheritdoc />
    public partial class TableNarudzba : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<string>(
                name: "PaymentId",
                table: "Narudzba",
                type: "nvarchar(max)",
                nullable: true);

            migrationBuilder.UpdateData(
                table: "Korisnici",
                keyColumn: "Id",
                keyValue: 1001,
                columns: new[] { "LozinkaHash", "LozinkaSalt" },
                values: new object[] { "Y4InbnIMsml/KDeA5tkbRBpxFG8=", "Ll8HQd/zSb06/fpiFi7fRA==" });

            migrationBuilder.UpdateData(
                table: "Korisnici",
                keyColumn: "Id",
                keyValue: 1002,
                columns: new[] { "LozinkaHash", "LozinkaSalt" },
                values: new object[] { "ZmLw42etzmWgvQPNbAaqjrq14Ww=", "d6vDYLYIgEH81KAgQi1XGg==" });

            migrationBuilder.UpdateData(
                table: "Korisnici",
                keyColumn: "Id",
                keyValue: 1007,
                columns: new[] { "LozinkaHash", "LozinkaSalt" },
                values: new object[] { "+d1YEBFeG1YW8aRRXgZgmASBj3M=", "Wn2W1F3XtKQD/9SeVSSjRA==" });

            migrationBuilder.UpdateData(
                table: "KorisniciUloge",
                keyColumn: "KorisnikUlogaId",
                keyValue: 1,
                column: "DatumIzmjene",
                value: new DateTime(2025, 8, 25, 14, 53, 46, 608, DateTimeKind.Local).AddTicks(8612));

            migrationBuilder.UpdateData(
                table: "KorisniciUloge",
                keyColumn: "KorisnikUlogaId",
                keyValue: 2,
                column: "DatumIzmjene",
                value: new DateTime(2025, 8, 25, 14, 53, 46, 608, DateTimeKind.Local).AddTicks(8666));

            migrationBuilder.UpdateData(
                table: "Narudzba",
                keyColumn: "Id",
                keyValue: 6000,
                columns: new[] { "DatumNarudzbe", "PaymentId" },
                values: new object[] { new DateTime(2025, 8, 25, 14, 53, 46, 608, DateTimeKind.Local).AddTicks(9262), null });
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "PaymentId",
                table: "Narudzba");

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
                table: "Narudzba",
                keyColumn: "Id",
                keyValue: 6000,
                column: "DatumNarudzbe",
                value: new DateTime(2025, 8, 22, 21, 22, 18, 889, DateTimeKind.Local).AddTicks(7881));
        }
    }
}
