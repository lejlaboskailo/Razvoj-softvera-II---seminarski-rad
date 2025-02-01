using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace eRestoran.Services.Migrations
{
    /// <inheritdoc />
    public partial class UpdatedKorisniks : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.UpdateData(
                table: "Korisnici",
                keyColumn: "Id",
                keyValue: 1001,
                columns: new[] { "LozinkaHash", "LozinkaSalt" },
                values: new object[] { "Xw1lDKIFvuAtYC0ZzPWaEEPjSJY=", "NmPdd4k6+kdh9H16cFWVMQ==" });

            migrationBuilder.UpdateData(
                table: "Korisnici",
                keyColumn: "Id",
                keyValue: 1002,
                columns: new[] { "LozinkaHash", "LozinkaSalt" },
                values: new object[] { "NEXh/uHL8j0FaozwuiyD+mK9kOI=", "tR/P1KBRLbibkrN8ldIt7A==" });

            migrationBuilder.InsertData(
                table: "Korisnici",
                columns: new[] { "Id", "DrzavaId", "Email", "GradId", "Ime", "KorisnickoIme", "LozinkaHash", "LozinkaSalt", "Prezime", "Telefon" },
                values: new object[] { 1007, null, "heris@gmail.com", null, "Haris", "korisnik", "ZUfd5R6bBrxupDVGSVk41mfMPTI=", "Pyo1YWEAOEGd6I+xwhe9+A==", "Boskailo", "066455778" });

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

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DeleteData(
                table: "Korisnici",
                keyColumn: "Id",
                keyValue: 1007);

            migrationBuilder.UpdateData(
                table: "Korisnici",
                keyColumn: "Id",
                keyValue: 1001,
                columns: new[] { "LozinkaHash", "LozinkaSalt" },
                values: new object[] { "4YMX48dFwkPHZqCdEU2EGMPi89w=", "su5aXN1J+xiUv6P3Fe0Zzw==" });

            migrationBuilder.UpdateData(
                table: "Korisnici",
                keyColumn: "Id",
                keyValue: 1002,
                columns: new[] { "LozinkaHash", "LozinkaSalt" },
                values: new object[] { "3wx6xYfyNi7HndSFgImYfmKMuaY=", "Ro9poIclNlY+9NOueGLQew==" });

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
    }
}
