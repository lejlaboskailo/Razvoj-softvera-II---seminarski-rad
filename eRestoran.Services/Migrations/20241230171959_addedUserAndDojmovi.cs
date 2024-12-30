using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace eRestoran.Services.Migrations
{
    /// <inheritdoc />
    public partial class addedUserAndDojmovi : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.UpdateData(
                table: "Korisnici",
                keyColumn: "Id",
                keyValue: 1001,
                columns: new[] { "LozinkaHash", "LozinkaSalt" },
                values: new object[] { "rfwSLd+m0RxxWalGYIdH+Mz/psw=", "o9khsB+tY6WarZIjK0dXkQ==" });

            migrationBuilder.UpdateData(
                table: "Korisnici",
                keyColumn: "Id",
                keyValue: 1002,
                columns: new[] { "LozinkaHash", "LozinkaSalt" },
                values: new object[] { "pxpAUlGOlvlVoQdn8YJH1ieAA5E=", "odairAIRZOuxS28G1t/Nkw==" });

            migrationBuilder.InsertData(
                table: "Korisnici",
                columns: new[] { "Id", "DrzavaId", "GradId", "Ime", "KorisnickoIme", "LozinkaHash", "LozinkaSalt", "Prezime" },
                values: new object[] { 1007, null, null, "Lejla", "korisnik", "JpOi//OD7A7KLmDiuHO4Y4vNdG0=", "M6s6KeT+yqjLgXCCtPJvTQ==", "Boskailo" });

            migrationBuilder.UpdateData(
                table: "KorisniciUloge",
                keyColumn: "KorisnikUlogaId",
                keyValue: 1,
                column: "DatumIzmjene",
                value: new DateTime(2024, 12, 30, 18, 19, 59, 76, DateTimeKind.Local).AddTicks(6371));

            migrationBuilder.UpdateData(
                table: "KorisniciUloge",
                keyColumn: "KorisnikUlogaId",
                keyValue: 2,
                column: "DatumIzmjene",
                value: new DateTime(2024, 12, 30, 18, 19, 59, 76, DateTimeKind.Local).AddTicks(6417));

            migrationBuilder.UpdateData(
                table: "Narudzba",
                keyColumn: "Id",
                keyValue: 6000,
                column: "DatumNarudzbe",
                value: new DateTime(2024, 12, 30, 18, 19, 59, 76, DateTimeKind.Local).AddTicks(6983));
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
                values: new object[] { "XnHkkoa5lr+syCmd73hAM8BFowk=", "Eiu9KmQL+4UomONBWkR9TA==" });

            migrationBuilder.UpdateData(
                table: "Korisnici",
                keyColumn: "Id",
                keyValue: 1002,
                columns: new[] { "LozinkaHash", "LozinkaSalt" },
                values: new object[] { "V4Gci9eFnp8EK4maJIAM/3h0OdQ=", "o8+TUFncooIlZcLTZk3Nkg==" });

            migrationBuilder.UpdateData(
                table: "KorisniciUloge",
                keyColumn: "KorisnikUlogaId",
                keyValue: 1,
                column: "DatumIzmjene",
                value: new DateTime(2024, 12, 30, 18, 7, 41, 348, DateTimeKind.Local).AddTicks(6907));

            migrationBuilder.UpdateData(
                table: "KorisniciUloge",
                keyColumn: "KorisnikUlogaId",
                keyValue: 2,
                column: "DatumIzmjene",
                value: new DateTime(2024, 12, 30, 18, 7, 41, 348, DateTimeKind.Local).AddTicks(6952));

            migrationBuilder.UpdateData(
                table: "Narudzba",
                keyColumn: "Id",
                keyValue: 6000,
                column: "DatumNarudzbe",
                value: new DateTime(2024, 12, 30, 18, 7, 41, 348, DateTimeKind.Local).AddTicks(7694));
        }
    }
}
