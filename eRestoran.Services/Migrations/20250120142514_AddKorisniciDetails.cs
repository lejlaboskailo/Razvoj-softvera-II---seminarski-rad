using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace eRestoran.Services.Migrations
{
    /// <inheritdoc />
    public partial class AddKorisniciDetails : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<string>(
                name: "Email",
                table: "Korisnici",
                type: "nvarchar(max)",
                nullable: true);

            migrationBuilder.AddColumn<string>(
                name: "Telefon",
                table: "Korisnici",
                type: "nvarchar(max)",
                nullable: true);

            migrationBuilder.UpdateData(
                table: "Korisnici",
                keyColumn: "Id",
                keyValue: 1001,
                columns: new[] { "Email", "LozinkaHash", "LozinkaSalt", "Telefon" },
                values: new object[] { "medzida@gmail.com", "rKyDjgN+Ay/JC5JpvpobXB9HRGw=", "dfDUv7ow/3ijB3mMkq3waw==", "066455778" });

            migrationBuilder.UpdateData(
                table: "Korisnici",
                keyColumn: "Id",
                keyValue: 1002,
                columns: new[] { "Email", "LozinkaHash", "LozinkaSalt", "Telefon" },
                values: new object[] { "ena@gmail.com", "18C/NPVCC5QuQPcQLCmPaYpsi6U=", "lerO4ZCyhDFiUdkxhkUj+A==", "066455778" });

            migrationBuilder.UpdateData(
                table: "Korisnici",
                keyColumn: "Id",
                keyValue: 1007,
                columns: new[] { "Email", "LozinkaHash", "LozinkaSalt", "Telefon" },
                values: new object[] { "lejla@gmail.com", "miQeTaWOrTx5VM+UVTb98Iqedd8=", "EAXCe2XSAvALjnx/fS4cjg==", "066455778" });

            migrationBuilder.UpdateData(
                table: "KorisniciUloge",
                keyColumn: "KorisnikUlogaId",
                keyValue: 1,
                column: "DatumIzmjene",
                value: new DateTime(2025, 1, 20, 15, 25, 13, 853, DateTimeKind.Local).AddTicks(6637));

            migrationBuilder.UpdateData(
                table: "KorisniciUloge",
                keyColumn: "KorisnikUlogaId",
                keyValue: 2,
                column: "DatumIzmjene",
                value: new DateTime(2025, 1, 20, 15, 25, 13, 853, DateTimeKind.Local).AddTicks(6687));

            migrationBuilder.UpdateData(
                table: "Narudzba",
                keyColumn: "Id",
                keyValue: 6000,
                column: "DatumNarudzbe",
                value: new DateTime(2025, 1, 20, 15, 25, 13, 853, DateTimeKind.Local).AddTicks(7269));
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "Email",
                table: "Korisnici");

            migrationBuilder.DropColumn(
                name: "Telefon",
                table: "Korisnici");

            migrationBuilder.UpdateData(
                table: "Korisnici",
                keyColumn: "Id",
                keyValue: 1001,
                columns: new[] { "LozinkaHash", "LozinkaSalt" },
                values: new object[] { "MQZgbOenHjCiuDAWTRMJ4bl9fCE=", "qDfX7hRtbFf61N2sjUMUFw==" });

            migrationBuilder.UpdateData(
                table: "Korisnici",
                keyColumn: "Id",
                keyValue: 1002,
                columns: new[] { "LozinkaHash", "LozinkaSalt" },
                values: new object[] { "BkK4hBSXQftXQEysheCs+Vhppq4=", "PAxBylDbx9t3GQEHgxgwRA==" });

            migrationBuilder.UpdateData(
                table: "Korisnici",
                keyColumn: "Id",
                keyValue: 1007,
                columns: new[] { "LozinkaHash", "LozinkaSalt" },
                values: new object[] { "4cJQ7WaYBqXLT/ha929T5GyiJKw=", "pvNKERZZAVlfkH9CB4iMYg==" });

            migrationBuilder.UpdateData(
                table: "KorisniciUloge",
                keyColumn: "KorisnikUlogaId",
                keyValue: 1,
                column: "DatumIzmjene",
                value: new DateTime(2025, 1, 20, 14, 4, 21, 668, DateTimeKind.Local).AddTicks(3410));

            migrationBuilder.UpdateData(
                table: "KorisniciUloge",
                keyColumn: "KorisnikUlogaId",
                keyValue: 2,
                column: "DatumIzmjene",
                value: new DateTime(2025, 1, 20, 14, 4, 21, 668, DateTimeKind.Local).AddTicks(3461));

            migrationBuilder.UpdateData(
                table: "Narudzba",
                keyColumn: "Id",
                keyValue: 6000,
                column: "DatumNarudzbe",
                value: new DateTime(2025, 1, 20, 14, 4, 21, 668, DateTimeKind.Local).AddTicks(4047));
        }
    }
}
