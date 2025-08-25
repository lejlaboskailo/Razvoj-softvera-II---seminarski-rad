using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace eRestoran.Services.Migrations
{
    /// <inheritdoc />
    public partial class UplataDat : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DeleteData(
                table: "Uplata",
                keyColumn: "Id",
                keyValue: 5312);

            migrationBuilder.UpdateData(
                table: "Korisnici",
                keyColumn: "Id",
                keyValue: 1001,
                columns: new[] { "LozinkaHash", "LozinkaSalt" },
                values: new object[] { "NJLrqfQ6OBzw4Inl0c2Xi0arZMQ=", "jgd8z1YnjXwOKxGncyjBHw==" });

            migrationBuilder.UpdateData(
                table: "Korisnici",
                keyColumn: "Id",
                keyValue: 1002,
                columns: new[] { "LozinkaHash", "LozinkaSalt" },
                values: new object[] { "TltPwYeBZdW1BCcbif86uHuX4SY=", "8V7bddpDWlHawp5R2y7u4Q==" });

            migrationBuilder.UpdateData(
                table: "Korisnici",
                keyColumn: "Id",
                keyValue: 1007,
                columns: new[] { "LozinkaHash", "LozinkaSalt" },
                values: new object[] { "2ltVhW1vNJKTgi8tpgFG8aBLRtg=", "P5nPWODoWS8R3fEEp5uDSQ==" });

            migrationBuilder.UpdateData(
                table: "KorisniciUloge",
                keyColumn: "KorisnikUlogaId",
                keyValue: 1,
                column: "DatumIzmjene",
                value: new DateTime(2025, 8, 25, 19, 19, 46, 592, DateTimeKind.Local).AddTicks(8667));

            migrationBuilder.UpdateData(
                table: "KorisniciUloge",
                keyColumn: "KorisnikUlogaId",
                keyValue: 2,
                column: "DatumIzmjene",
                value: new DateTime(2025, 8, 25, 19, 19, 46, 592, DateTimeKind.Local).AddTicks(8712));

            migrationBuilder.UpdateData(
                table: "Narudzba",
                keyColumn: "Id",
                keyValue: 6000,
                column: "DatumNarudzbe",
                value: new DateTime(2025, 8, 25, 19, 19, 46, 592, DateTimeKind.Local).AddTicks(9338));
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.UpdateData(
                table: "Korisnici",
                keyColumn: "Id",
                keyValue: 1001,
                columns: new[] { "LozinkaHash", "LozinkaSalt" },
                values: new object[] { "O5cPQ8JytonKsyl3rhun9LjdeDs=", "MhOPoPnbbr659gYQJgg+tQ==" });

            migrationBuilder.UpdateData(
                table: "Korisnici",
                keyColumn: "Id",
                keyValue: 1002,
                columns: new[] { "LozinkaHash", "LozinkaSalt" },
                values: new object[] { "cbbppIa/M0BC6kRjgkVgBSBJhM4=", "siYA/87lf2WU9EvsfOpXIw==" });

            migrationBuilder.UpdateData(
                table: "Korisnici",
                keyColumn: "Id",
                keyValue: 1007,
                columns: new[] { "LozinkaHash", "LozinkaSalt" },
                values: new object[] { "LZlD+6mRNFxotlztTB72Vw/A/ns=", "UbKR/XVxV2LOI1JK0sp8Jg==" });

            migrationBuilder.UpdateData(
                table: "KorisniciUloge",
                keyColumn: "KorisnikUlogaId",
                keyValue: 1,
                column: "DatumIzmjene",
                value: new DateTime(2025, 8, 25, 18, 59, 2, 805, DateTimeKind.Local).AddTicks(7034));

            migrationBuilder.UpdateData(
                table: "KorisniciUloge",
                keyColumn: "KorisnikUlogaId",
                keyValue: 2,
                column: "DatumIzmjene",
                value: new DateTime(2025, 8, 25, 18, 59, 2, 805, DateTimeKind.Local).AddTicks(7078));

            migrationBuilder.UpdateData(
                table: "Narudzba",
                keyColumn: "Id",
                keyValue: 6000,
                column: "DatumNarudzbe",
                value: new DateTime(2025, 8, 25, 18, 59, 2, 805, DateTimeKind.Local).AddTicks(7689));

            migrationBuilder.InsertData(
                table: "Uplata",
                columns: new[] { "Id", "BrojTransakcije", "DatumTransakcije", "Iznos", "KorisnikId", "NacinPlacanja" },
                values: new object[] { 5312, "GHVDGBNNH877", new DateTime(2025, 8, 25, 12, 0, 0, 0, DateTimeKind.Utc), 30m, 1002, "gotovina" });
        }
    }
}
