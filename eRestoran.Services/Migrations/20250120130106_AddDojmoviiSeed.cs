using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

#pragma warning disable CA1814 // Prefer jagged arrays over multidimensional

namespace eRestoran.Services.Migrations
{
    /// <inheritdoc />
    public partial class AddDojmoviiSeed : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.InsertData(
                table: "Dojmovi",
                columns: new[] { "Id", "JeloId", "KorisnikId", "Ocjena", "Opis" },
                values: new object[,]
                {
                    { 9112, 5005, 1001, 4, "odlicna dostava" },
                    { 9113, 5005, 1001, 3, "odlicna dostava" },
                    { 9114, 5005, 1002, 4, "odlicna dostava" },
                    { 9115, 5005, 1002, 5, "odlicna dostava" },
                    { 9116, 5005, 1007, 5, "odlicna dostava" }
                });

            migrationBuilder.UpdateData(
                table: "Korisnici",
                keyColumn: "Id",
                keyValue: 1001,
                columns: new[] { "LozinkaHash", "LozinkaSalt" },
                values: new object[] { "2PhY6tEr/SBUcR2CIl0zOggHQLE=", "UnudcX4LlSTM3Fp607FHUg==" });

            migrationBuilder.UpdateData(
                table: "Korisnici",
                keyColumn: "Id",
                keyValue: 1002,
                columns: new[] { "LozinkaHash", "LozinkaSalt" },
                values: new object[] { "u0RaamIkHMGEiZazuncsG+duCwo=", "nI194LRrwre3UaHebj5IKw==" });

            migrationBuilder.UpdateData(
                table: "Korisnici",
                keyColumn: "Id",
                keyValue: 1007,
                columns: new[] { "LozinkaHash", "LozinkaSalt" },
                values: new object[] { "H+lfvmX7oAbGql5jVHtW/708fAM=", "KZ97a0DuYhFEREMcI6jIMA==" });

            migrationBuilder.UpdateData(
                table: "KorisniciUloge",
                keyColumn: "KorisnikUlogaId",
                keyValue: 1,
                column: "DatumIzmjene",
                value: new DateTime(2025, 1, 20, 14, 1, 6, 412, DateTimeKind.Local).AddTicks(9893));

            migrationBuilder.UpdateData(
                table: "KorisniciUloge",
                keyColumn: "KorisnikUlogaId",
                keyValue: 2,
                column: "DatumIzmjene",
                value: new DateTime(2025, 1, 20, 14, 1, 6, 412, DateTimeKind.Local).AddTicks(9941));

            migrationBuilder.UpdateData(
                table: "Narudzba",
                keyColumn: "Id",
                keyValue: 6000,
                column: "DatumNarudzbe",
                value: new DateTime(2025, 1, 20, 14, 1, 6, 413, DateTimeKind.Local).AddTicks(515));
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DeleteData(
                table: "Dojmovi",
                keyColumn: "Id",
                keyValue: 9112);

            migrationBuilder.DeleteData(
                table: "Dojmovi",
                keyColumn: "Id",
                keyValue: 9113);

            migrationBuilder.DeleteData(
                table: "Dojmovi",
                keyColumn: "Id",
                keyValue: 9114);

            migrationBuilder.DeleteData(
                table: "Dojmovi",
                keyColumn: "Id",
                keyValue: 9115);

            migrationBuilder.DeleteData(
                table: "Dojmovi",
                keyColumn: "Id",
                keyValue: 9116);

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
    }
}
