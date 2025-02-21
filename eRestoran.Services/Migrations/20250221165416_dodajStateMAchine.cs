using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace eRestoran.Services.Migrations
{
    /// <inheritdoc />
    public partial class dodajStateMAchine : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<string>(
                name: "StateMachine",
                table: "Jelo",
                type: "nvarchar(max)",
                nullable: true);

            migrationBuilder.UpdateData(
                table: "Jelo",
                keyColumn: "Id",
                keyValue: 5000,
                column: "StateMachine",
                value: "active");

            migrationBuilder.UpdateData(
                table: "Jelo",
                keyColumn: "Id",
                keyValue: 5001,
                column: "StateMachine",
                value: "active");

            migrationBuilder.UpdateData(
                table: "Jelo",
                keyColumn: "Id",
                keyValue: 5002,
                column: "StateMachine",
                value: "active");

            migrationBuilder.UpdateData(
                table: "Jelo",
                keyColumn: "Id",
                keyValue: 5004,
                column: "StateMachine",
                value: "draft");

            migrationBuilder.UpdateData(
                table: "Jelo",
                keyColumn: "Id",
                keyValue: 5005,
                column: "StateMachine",
                value: "cancelled");

            migrationBuilder.UpdateData(
                table: "Korisnici",
                keyColumn: "Id",
                keyValue: 1001,
                columns: new[] { "LozinkaHash", "LozinkaSalt" },
                values: new object[] { "pj/iypkCO9FHQTwcVcxx8ClG1mc=", "n6zW0GErZz33JfWjaIOhJQ==" });

            migrationBuilder.UpdateData(
                table: "Korisnici",
                keyColumn: "Id",
                keyValue: 1002,
                columns: new[] { "LozinkaHash", "LozinkaSalt" },
                values: new object[] { "/WgnJm0mG17VwtA2It0U+zUWDMo=", "iAWP0prz+L3MgCdG6gkx2g==" });

            migrationBuilder.UpdateData(
                table: "Korisnici",
                keyColumn: "Id",
                keyValue: 1007,
                columns: new[] { "LozinkaHash", "LozinkaSalt" },
                values: new object[] { "8Ec3586vDuXMJ0NW/DYEf9x4mWg=", "ec4+LbH2r12iQxShvsSHzA==" });

            migrationBuilder.UpdateData(
                table: "KorisniciUloge",
                keyColumn: "KorisnikUlogaId",
                keyValue: 1,
                column: "DatumIzmjene",
                value: new DateTime(2025, 2, 21, 17, 54, 15, 788, DateTimeKind.Local).AddTicks(838));

            migrationBuilder.UpdateData(
                table: "KorisniciUloge",
                keyColumn: "KorisnikUlogaId",
                keyValue: 2,
                column: "DatumIzmjene",
                value: new DateTime(2025, 2, 21, 17, 54, 15, 788, DateTimeKind.Local).AddTicks(886));

            migrationBuilder.UpdateData(
                table: "Narudzba",
                keyColumn: "Id",
                keyValue: 6000,
                column: "DatumNarudzbe",
                value: new DateTime(2025, 2, 21, 17, 54, 15, 788, DateTimeKind.Local).AddTicks(1540));
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "StateMachine",
                table: "Jelo");

            migrationBuilder.UpdateData(
                table: "Korisnici",
                keyColumn: "Id",
                keyValue: 1001,
                columns: new[] { "LozinkaHash", "LozinkaSalt" },
                values: new object[] { "4hXRRGrFRfXjFPFQ6ODqhCkSJ0g=", "FeO2//J50iQXuRUvZWY4Ew==" });

            migrationBuilder.UpdateData(
                table: "Korisnici",
                keyColumn: "Id",
                keyValue: 1002,
                columns: new[] { "LozinkaHash", "LozinkaSalt" },
                values: new object[] { "+w6mSF+VonFRxLtrr8E8jgE5VhM=", "7WyGopQsJVSDIC6xGb1UjA==" });

            migrationBuilder.UpdateData(
                table: "Korisnici",
                keyColumn: "Id",
                keyValue: 1007,
                columns: new[] { "LozinkaHash", "LozinkaSalt" },
                values: new object[] { "a6NL3QkbvZKTScUZsy4tZ5ikY5I=", "FL7CXrJXjt6O0AkDfR27Hg==" });

            migrationBuilder.UpdateData(
                table: "KorisniciUloge",
                keyColumn: "KorisnikUlogaId",
                keyValue: 1,
                column: "DatumIzmjene",
                value: new DateTime(2025, 2, 21, 16, 38, 32, 218, DateTimeKind.Local).AddTicks(6655));

            migrationBuilder.UpdateData(
                table: "KorisniciUloge",
                keyColumn: "KorisnikUlogaId",
                keyValue: 2,
                column: "DatumIzmjene",
                value: new DateTime(2025, 2, 21, 16, 38, 32, 218, DateTimeKind.Local).AddTicks(6702));

            migrationBuilder.UpdateData(
                table: "Narudzba",
                keyColumn: "Id",
                keyValue: 6000,
                column: "DatumNarudzbe",
                value: new DateTime(2025, 2, 21, 16, 38, 32, 218, DateTimeKind.Local).AddTicks(7373));
        }
    }
}
