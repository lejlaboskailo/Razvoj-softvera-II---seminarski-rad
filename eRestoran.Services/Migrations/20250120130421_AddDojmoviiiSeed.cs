using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace eRestoran.Services.Migrations
{
    /// <inheritdoc />
    public partial class AddDojmoviiiSeed : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.UpdateData(
                table: "Dojmovi",
                keyColumn: "Id",
                keyValue: 8001,
                column: "Ocjena",
                value: 2);

            migrationBuilder.UpdateData(
                table: "Dojmovi",
                keyColumn: "Id",
                keyValue: 8002,
                column: "Ocjena",
                value: 2);

            migrationBuilder.UpdateData(
                table: "Dojmovi",
                keyColumn: "Id",
                keyValue: 8006,
                column: "Ocjena",
                value: 2);

            migrationBuilder.UpdateData(
                table: "Dojmovi",
                keyColumn: "Id",
                keyValue: 9007,
                column: "Ocjena",
                value: 2);

            migrationBuilder.UpdateData(
                table: "Dojmovi",
                keyColumn: "Id",
                keyValue: 9008,
                column: "Ocjena",
                value: 2);

            migrationBuilder.UpdateData(
                table: "Dojmovi",
                keyColumn: "Id",
                keyValue: 9009,
                column: "Ocjena",
                value: 2);

            migrationBuilder.UpdateData(
                table: "Dojmovi",
                keyColumn: "Id",
                keyValue: 9100,
                column: "Ocjena",
                value: 2);

            migrationBuilder.UpdateData(
                table: "Dojmovi",
                keyColumn: "Id",
                keyValue: 9103,
                column: "Ocjena",
                value: 2);

            migrationBuilder.UpdateData(
                table: "Dojmovi",
                keyColumn: "Id",
                keyValue: 9107,
                column: "Ocjena",
                value: 2);

            migrationBuilder.UpdateData(
                table: "Dojmovi",
                keyColumn: "Id",
                keyValue: 9108,
                column: "Ocjena",
                value: 2);

            migrationBuilder.UpdateData(
                table: "Dojmovi",
                keyColumn: "Id",
                keyValue: 9111,
                column: "Ocjena",
                value: 2);

            migrationBuilder.UpdateData(
                table: "Dojmovi",
                keyColumn: "Id",
                keyValue: 9112,
                column: "Ocjena",
                value: 2);

            migrationBuilder.UpdateData(
                table: "Dojmovi",
                keyColumn: "Id",
                keyValue: 9115,
                column: "Ocjena",
                value: 2);

            migrationBuilder.UpdateData(
                table: "Dojmovi",
                keyColumn: "Id",
                keyValue: 9116,
                column: "Ocjena",
                value: 2);

            migrationBuilder.UpdateData(
                table: "Dojmovi",
                keyColumn: "Id",
                keyValue: 9150,
                column: "Ocjena",
                value: 2);

            migrationBuilder.UpdateData(
                table: "Dojmovi",
                keyColumn: "Id",
                keyValue: 9156,
                column: "Ocjena",
                value: 2);

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

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.UpdateData(
                table: "Dojmovi",
                keyColumn: "Id",
                keyValue: 8001,
                column: "Ocjena",
                value: 5);

            migrationBuilder.UpdateData(
                table: "Dojmovi",
                keyColumn: "Id",
                keyValue: 8002,
                column: "Ocjena",
                value: 5);

            migrationBuilder.UpdateData(
                table: "Dojmovi",
                keyColumn: "Id",
                keyValue: 8006,
                column: "Ocjena",
                value: 5);

            migrationBuilder.UpdateData(
                table: "Dojmovi",
                keyColumn: "Id",
                keyValue: 9007,
                column: "Ocjena",
                value: 5);

            migrationBuilder.UpdateData(
                table: "Dojmovi",
                keyColumn: "Id",
                keyValue: 9008,
                column: "Ocjena",
                value: 5);

            migrationBuilder.UpdateData(
                table: "Dojmovi",
                keyColumn: "Id",
                keyValue: 9009,
                column: "Ocjena",
                value: 5);

            migrationBuilder.UpdateData(
                table: "Dojmovi",
                keyColumn: "Id",
                keyValue: 9100,
                column: "Ocjena",
                value: 5);

            migrationBuilder.UpdateData(
                table: "Dojmovi",
                keyColumn: "Id",
                keyValue: 9103,
                column: "Ocjena",
                value: 5);

            migrationBuilder.UpdateData(
                table: "Dojmovi",
                keyColumn: "Id",
                keyValue: 9107,
                column: "Ocjena",
                value: 5);

            migrationBuilder.UpdateData(
                table: "Dojmovi",
                keyColumn: "Id",
                keyValue: 9108,
                column: "Ocjena",
                value: 5);

            migrationBuilder.UpdateData(
                table: "Dojmovi",
                keyColumn: "Id",
                keyValue: 9111,
                column: "Ocjena",
                value: 5);

            migrationBuilder.UpdateData(
                table: "Dojmovi",
                keyColumn: "Id",
                keyValue: 9112,
                column: "Ocjena",
                value: 4);

            migrationBuilder.UpdateData(
                table: "Dojmovi",
                keyColumn: "Id",
                keyValue: 9115,
                column: "Ocjena",
                value: 5);

            migrationBuilder.UpdateData(
                table: "Dojmovi",
                keyColumn: "Id",
                keyValue: 9116,
                column: "Ocjena",
                value: 5);

            migrationBuilder.UpdateData(
                table: "Dojmovi",
                keyColumn: "Id",
                keyValue: 9150,
                column: "Ocjena",
                value: 5);

            migrationBuilder.UpdateData(
                table: "Dojmovi",
                keyColumn: "Id",
                keyValue: 9156,
                column: "Ocjena",
                value: 5);

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
    }
}
