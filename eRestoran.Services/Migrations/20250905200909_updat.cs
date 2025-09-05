using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace eRestoran.Services.Migrations
{
    /// <inheritdoc />
    public partial class updat : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "DatumRecenzije",
                table: "Dojmovi");

            migrationBuilder.UpdateData(
                table: "Korisnici",
                keyColumn: "Id",
                keyValue: 1001,
                columns: new[] { "LozinkaHash", "LozinkaSalt" },
                values: new object[] { "KpwvJ5rRy5MfRng4ED3ISrAMRas=", "kW9m6riFsGlfJQI15R1OTw==" });

            migrationBuilder.UpdateData(
                table: "Korisnici",
                keyColumn: "Id",
                keyValue: 1002,
                columns: new[] { "LozinkaHash", "LozinkaSalt" },
                values: new object[] { "pZXGXYYbgtRVu+qUZ8gv1pRywFs=", "cQqmqdnCSovyvkOxrrBBsQ==" });

            migrationBuilder.UpdateData(
                table: "Korisnici",
                keyColumn: "Id",
                keyValue: 1007,
                columns: new[] { "LozinkaHash", "LozinkaSalt" },
                values: new object[] { "ogTXQmbYjkU4iLI3Q0jQ40ME4B0=", "4/m+xVWPk4Wc1jMEjsQcYg==" });

            migrationBuilder.UpdateData(
                table: "KorisniciUloge",
                keyColumn: "KorisnikUlogaId",
                keyValue: 1,
                column: "DatumIzmjene",
                value: new DateTime(2025, 9, 5, 22, 9, 9, 194, DateTimeKind.Local).AddTicks(1034));

            migrationBuilder.UpdateData(
                table: "KorisniciUloge",
                keyColumn: "KorisnikUlogaId",
                keyValue: 2,
                column: "DatumIzmjene",
                value: new DateTime(2025, 9, 5, 22, 9, 9, 194, DateTimeKind.Local).AddTicks(1105));

            migrationBuilder.UpdateData(
                table: "Narudzba",
                keyColumn: "Id",
                keyValue: 6000,
                column: "DatumNarudzbe",
                value: new DateTime(2025, 9, 5, 22, 9, 9, 194, DateTimeKind.Local).AddTicks(2187));
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<DateTime>(
                name: "DatumRecenzije",
                table: "Dojmovi",
                type: "datetime",
                nullable: true);

            migrationBuilder.UpdateData(
                table: "Dojmovi",
                keyColumn: "Id",
                keyValue: 8000,
                column: "DatumRecenzije",
                value: null);

            migrationBuilder.UpdateData(
                table: "Dojmovi",
                keyColumn: "Id",
                keyValue: 8001,
                column: "DatumRecenzije",
                value: null);

            migrationBuilder.UpdateData(
                table: "Dojmovi",
                keyColumn: "Id",
                keyValue: 8002,
                column: "DatumRecenzije",
                value: null);

            migrationBuilder.UpdateData(
                table: "Dojmovi",
                keyColumn: "Id",
                keyValue: 8003,
                column: "DatumRecenzije",
                value: null);

            migrationBuilder.UpdateData(
                table: "Dojmovi",
                keyColumn: "Id",
                keyValue: 8004,
                column: "DatumRecenzije",
                value: null);

            migrationBuilder.UpdateData(
                table: "Dojmovi",
                keyColumn: "Id",
                keyValue: 8005,
                column: "DatumRecenzije",
                value: null);

            migrationBuilder.UpdateData(
                table: "Dojmovi",
                keyColumn: "Id",
                keyValue: 8006,
                column: "DatumRecenzije",
                value: null);

            migrationBuilder.UpdateData(
                table: "Dojmovi",
                keyColumn: "Id",
                keyValue: 9007,
                column: "DatumRecenzije",
                value: null);

            migrationBuilder.UpdateData(
                table: "Dojmovi",
                keyColumn: "Id",
                keyValue: 9008,
                column: "DatumRecenzije",
                value: null);

            migrationBuilder.UpdateData(
                table: "Dojmovi",
                keyColumn: "Id",
                keyValue: 9009,
                column: "DatumRecenzije",
                value: null);

            migrationBuilder.UpdateData(
                table: "Dojmovi",
                keyColumn: "Id",
                keyValue: 9019,
                column: "DatumRecenzije",
                value: null);

            migrationBuilder.UpdateData(
                table: "Dojmovi",
                keyColumn: "Id",
                keyValue: 9100,
                column: "DatumRecenzije",
                value: null);

            migrationBuilder.UpdateData(
                table: "Dojmovi",
                keyColumn: "Id",
                keyValue: 9101,
                column: "DatumRecenzije",
                value: null);

            migrationBuilder.UpdateData(
                table: "Dojmovi",
                keyColumn: "Id",
                keyValue: 9102,
                column: "DatumRecenzije",
                value: null);

            migrationBuilder.UpdateData(
                table: "Dojmovi",
                keyColumn: "Id",
                keyValue: 9103,
                column: "DatumRecenzije",
                value: null);

            migrationBuilder.UpdateData(
                table: "Dojmovi",
                keyColumn: "Id",
                keyValue: 9106,
                column: "DatumRecenzije",
                value: null);

            migrationBuilder.UpdateData(
                table: "Dojmovi",
                keyColumn: "Id",
                keyValue: 9107,
                column: "DatumRecenzije",
                value: null);

            migrationBuilder.UpdateData(
                table: "Dojmovi",
                keyColumn: "Id",
                keyValue: 9108,
                column: "DatumRecenzije",
                value: null);

            migrationBuilder.UpdateData(
                table: "Dojmovi",
                keyColumn: "Id",
                keyValue: 9109,
                column: "DatumRecenzije",
                value: null);

            migrationBuilder.UpdateData(
                table: "Dojmovi",
                keyColumn: "Id",
                keyValue: 9110,
                column: "DatumRecenzije",
                value: null);

            migrationBuilder.UpdateData(
                table: "Dojmovi",
                keyColumn: "Id",
                keyValue: 9111,
                column: "DatumRecenzije",
                value: null);

            migrationBuilder.UpdateData(
                table: "Dojmovi",
                keyColumn: "Id",
                keyValue: 9112,
                column: "DatumRecenzije",
                value: null);

            migrationBuilder.UpdateData(
                table: "Dojmovi",
                keyColumn: "Id",
                keyValue: 9113,
                column: "DatumRecenzije",
                value: null);

            migrationBuilder.UpdateData(
                table: "Dojmovi",
                keyColumn: "Id",
                keyValue: 9114,
                column: "DatumRecenzije",
                value: null);

            migrationBuilder.UpdateData(
                table: "Dojmovi",
                keyColumn: "Id",
                keyValue: 9115,
                column: "DatumRecenzije",
                value: null);

            migrationBuilder.UpdateData(
                table: "Dojmovi",
                keyColumn: "Id",
                keyValue: 9116,
                column: "DatumRecenzije",
                value: null);

            migrationBuilder.UpdateData(
                table: "Dojmovi",
                keyColumn: "Id",
                keyValue: 9140,
                column: "DatumRecenzije",
                value: null);

            migrationBuilder.UpdateData(
                table: "Dojmovi",
                keyColumn: "Id",
                keyValue: 9150,
                column: "DatumRecenzije",
                value: null);

            migrationBuilder.UpdateData(
                table: "Dojmovi",
                keyColumn: "Id",
                keyValue: 9156,
                column: "DatumRecenzije",
                value: null);

            migrationBuilder.UpdateData(
                table: "Korisnici",
                keyColumn: "Id",
                keyValue: 1001,
                columns: new[] { "LozinkaHash", "LozinkaSalt" },
                values: new object[] { "oNz5bEJ+KlKfKkXLwqvh2GSKWDo=", "oZNf/MpjsQ1cHCKfhwkpag==" });

            migrationBuilder.UpdateData(
                table: "Korisnici",
                keyColumn: "Id",
                keyValue: 1002,
                columns: new[] { "LozinkaHash", "LozinkaSalt" },
                values: new object[] { "SzyMI/zYhJDP76KcH9J1cKL0JBs=", "0CM2NnU6oMgaMOrORw5TGQ==" });

            migrationBuilder.UpdateData(
                table: "Korisnici",
                keyColumn: "Id",
                keyValue: 1007,
                columns: new[] { "LozinkaHash", "LozinkaSalt" },
                values: new object[] { "YCZA2UZH4AcJ+JWDjpjxeKVg2qs=", "uLG9ttMF0yBpReRi4/BVDQ==" });

            migrationBuilder.UpdateData(
                table: "KorisniciUloge",
                keyColumn: "KorisnikUlogaId",
                keyValue: 1,
                column: "DatumIzmjene",
                value: new DateTime(2025, 9, 5, 21, 36, 32, 149, DateTimeKind.Local).AddTicks(9139));

            migrationBuilder.UpdateData(
                table: "KorisniciUloge",
                keyColumn: "KorisnikUlogaId",
                keyValue: 2,
                column: "DatumIzmjene",
                value: new DateTime(2025, 9, 5, 21, 36, 32, 149, DateTimeKind.Local).AddTicks(9191));

            migrationBuilder.UpdateData(
                table: "Narudzba",
                keyColumn: "Id",
                keyValue: 6000,
                column: "DatumNarudzbe",
                value: new DateTime(2025, 9, 5, 21, 36, 32, 149, DateTimeKind.Local).AddTicks(9753));
        }
    }
}
