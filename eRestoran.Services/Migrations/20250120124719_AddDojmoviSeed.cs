using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

#pragma warning disable CA1814 // Prefer jagged arrays over multidimensional

namespace eRestoran.Services.Migrations
{
    /// <inheritdoc />
    public partial class AddDojmoviSeed : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.InsertData(
                table: "Dojmovi",
                columns: new[] { "Id", "JeloId", "KorisnikId", "Ocjena", "Opis" },
                values: new object[,]
                {
                    { 9106, 5001, 1001, 5, "odlicna dostava" },
                    { 9107, 5002, 1001, 5, "odlicna dostava" },
                    { 9108, 5004, 1002, 5, "odlicna dostava" },
                    { 9109, 5002, 1001, 4, "odlicna dostava" },
                    { 9110, 5002, 1002, 3, "odlicna dostava" },
                    { 9111, 5004, 1001, 5, "odlicna dostava" },
                    { 9140, 5001, 1007, 5, "odlicna dostava" },
                    { 9150, 5001, 1007, 5, "odlicna dostava" },
                    { 9156, 5001, 1002, 5, "odlicna dostava" }
                });

            migrationBuilder.UpdateData(
                table: "Korisnici",
                keyColumn: "Id",
                keyValue: 1001,
                columns: new[] { "LozinkaHash", "LozinkaSalt" },
                values: new object[] { "v5TVBsi1l3C3C7w4sW9e914xutg=", "FgOaJbNjoDZ2crPJEE9gIQ==" });

            migrationBuilder.UpdateData(
                table: "Korisnici",
                keyColumn: "Id",
                keyValue: 1002,
                columns: new[] { "LozinkaHash", "LozinkaSalt" },
                values: new object[] { "fbDPOQvKL33wwSxGglMmbr7O6LQ=", "asy6AD/2q84pZgRIaGu6CQ==" });

            migrationBuilder.UpdateData(
                table: "Korisnici",
                keyColumn: "Id",
                keyValue: 1007,
                columns: new[] { "LozinkaHash", "LozinkaSalt" },
                values: new object[] { "ataz0fTNh8MVPAY+iUqE5Bh1mOY=", "D/h81bsOX3HmizZ7u0s9GA==" });

            migrationBuilder.UpdateData(
                table: "KorisniciUloge",
                keyColumn: "KorisnikUlogaId",
                keyValue: 1,
                column: "DatumIzmjene",
                value: new DateTime(2025, 1, 20, 13, 47, 19, 263, DateTimeKind.Local).AddTicks(1596));

            migrationBuilder.UpdateData(
                table: "KorisniciUloge",
                keyColumn: "KorisnikUlogaId",
                keyValue: 2,
                column: "DatumIzmjene",
                value: new DateTime(2025, 1, 20, 13, 47, 19, 263, DateTimeKind.Local).AddTicks(1638));

            migrationBuilder.UpdateData(
                table: "Narudzba",
                keyColumn: "Id",
                keyValue: 6000,
                column: "DatumNarudzbe",
                value: new DateTime(2025, 1, 20, 13, 47, 19, 263, DateTimeKind.Local).AddTicks(2244));
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DeleteData(
                table: "Dojmovi",
                keyColumn: "Id",
                keyValue: 9106);

            migrationBuilder.DeleteData(
                table: "Dojmovi",
                keyColumn: "Id",
                keyValue: 9107);

            migrationBuilder.DeleteData(
                table: "Dojmovi",
                keyColumn: "Id",
                keyValue: 9108);

            migrationBuilder.DeleteData(
                table: "Dojmovi",
                keyColumn: "Id",
                keyValue: 9109);

            migrationBuilder.DeleteData(
                table: "Dojmovi",
                keyColumn: "Id",
                keyValue: 9110);

            migrationBuilder.DeleteData(
                table: "Dojmovi",
                keyColumn: "Id",
                keyValue: 9111);

            migrationBuilder.DeleteData(
                table: "Dojmovi",
                keyColumn: "Id",
                keyValue: 9140);

            migrationBuilder.DeleteData(
                table: "Dojmovi",
                keyColumn: "Id",
                keyValue: 9150);

            migrationBuilder.DeleteData(
                table: "Dojmovi",
                keyColumn: "Id",
                keyValue: 9156);

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
    }
}
