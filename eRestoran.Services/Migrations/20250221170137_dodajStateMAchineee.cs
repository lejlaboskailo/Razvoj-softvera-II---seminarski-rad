using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace eRestoran.Services.Migrations
{
    /// <inheritdoc />
    public partial class dodajStateMAchineee : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.UpdateData(
                table: "Dojmovi",
                keyColumn: "Id",
                keyValue: 9101,
                column: "KorisnikId",
                value: 1002);

            migrationBuilder.UpdateData(
                table: "Dojmovi",
                keyColumn: "Id",
                keyValue: 9102,
                column: "KorisnikId",
                value: 1002);

            migrationBuilder.UpdateData(
                table: "Dojmovi",
                keyColumn: "Id",
                keyValue: 9103,
                column: "KorisnikId",
                value: 1002);

            migrationBuilder.UpdateData(
                table: "Dojmovi",
                keyColumn: "Id",
                keyValue: 9116,
                column: "KorisnikId",
                value: 1002);

            migrationBuilder.UpdateData(
                table: "Dojmovi",
                keyColumn: "Id",
                keyValue: 9140,
                column: "KorisnikId",
                value: 1002);

            migrationBuilder.UpdateData(
                table: "Dojmovi",
                keyColumn: "Id",
                keyValue: 9150,
                column: "KorisnikId",
                value: 1002);

            migrationBuilder.UpdateData(
                table: "Jelo",
                keyColumn: "Id",
                keyValue: 5000,
                column: "StateMachine",
                value: null);

            migrationBuilder.UpdateData(
                table: "Jelo",
                keyColumn: "Id",
                keyValue: 5001,
                column: "StateMachine",
                value: null);

            migrationBuilder.UpdateData(
                table: "Jelo",
                keyColumn: "Id",
                keyValue: 5002,
                column: "StateMachine",
                value: null);

            migrationBuilder.UpdateData(
                table: "Jelo",
                keyColumn: "Id",
                keyValue: 5004,
                column: "StateMachine",
                value: null);

            migrationBuilder.UpdateData(
                table: "Jelo",
                keyColumn: "Id",
                keyValue: 5005,
                column: "StateMachine",
                value: null);

            migrationBuilder.UpdateData(
                table: "Korisnici",
                keyColumn: "Id",
                keyValue: 1001,
                columns: new[] { "LozinkaHash", "LozinkaSalt" },
                values: new object[] { "dccXv42ZUO52MsQgK+aGjgnkhvY=", "VS6RiKVDfLyOsy1P88iVbw==" });

            migrationBuilder.UpdateData(
                table: "Korisnici",
                keyColumn: "Id",
                keyValue: 1002,
                columns: new[] { "LozinkaHash", "LozinkaSalt" },
                values: new object[] { "GDyciFpgmxLe88NEmCBcYtwclz4=", "wymK71fyg8Plm+nnjcWjTQ==" });

            migrationBuilder.UpdateData(
                table: "Korisnici",
                keyColumn: "Id",
                keyValue: 1007,
                columns: new[] { "LozinkaHash", "LozinkaSalt" },
                values: new object[] { "9m/vQ5hcu1l7VrFRYHg9CgL8AvQ=", "JOZC4+XmbnfHa8lJbLCwKw==" });

            migrationBuilder.UpdateData(
                table: "KorisniciUloge",
                keyColumn: "KorisnikUlogaId",
                keyValue: 1,
                column: "DatumIzmjene",
                value: new DateTime(2025, 2, 21, 18, 1, 36, 865, DateTimeKind.Local).AddTicks(4719));

            migrationBuilder.UpdateData(
                table: "KorisniciUloge",
                keyColumn: "KorisnikUlogaId",
                keyValue: 2,
                column: "DatumIzmjene",
                value: new DateTime(2025, 2, 21, 18, 1, 36, 865, DateTimeKind.Local).AddTicks(4762));

            migrationBuilder.UpdateData(
                table: "Narudzba",
                keyColumn: "Id",
                keyValue: 6000,
                column: "DatumNarudzbe",
                value: new DateTime(2025, 2, 21, 18, 1, 36, 865, DateTimeKind.Local).AddTicks(5418));
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.UpdateData(
                table: "Dojmovi",
                keyColumn: "Id",
                keyValue: 9101,
                column: "KorisnikId",
                value: 1007);

            migrationBuilder.UpdateData(
                table: "Dojmovi",
                keyColumn: "Id",
                keyValue: 9102,
                column: "KorisnikId",
                value: 1007);

            migrationBuilder.UpdateData(
                table: "Dojmovi",
                keyColumn: "Id",
                keyValue: 9103,
                column: "KorisnikId",
                value: 1007);

            migrationBuilder.UpdateData(
                table: "Dojmovi",
                keyColumn: "Id",
                keyValue: 9116,
                column: "KorisnikId",
                value: 1001);

            migrationBuilder.UpdateData(
                table: "Dojmovi",
                keyColumn: "Id",
                keyValue: 9140,
                column: "KorisnikId",
                value: 1007);

            migrationBuilder.UpdateData(
                table: "Dojmovi",
                keyColumn: "Id",
                keyValue: 9150,
                column: "KorisnikId",
                value: 1007);

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
                values: new object[] { "9AlMf9iZUdStXIY3B5uy9nWuL1s=", "TVksIssJ6X4mVDCWEf4yQQ==" });

            migrationBuilder.UpdateData(
                table: "Korisnici",
                keyColumn: "Id",
                keyValue: 1002,
                columns: new[] { "LozinkaHash", "LozinkaSalt" },
                values: new object[] { "0yuhB1OIUTJVWU5npmA2kBt72Rw=", "NevjmxOeVToe7eGO3ARKHg==" });

            migrationBuilder.UpdateData(
                table: "Korisnici",
                keyColumn: "Id",
                keyValue: 1007,
                columns: new[] { "LozinkaHash", "LozinkaSalt" },
                values: new object[] { "5BQYTPKtYoWRolSg1mh50DVzL8Q=", "WM7On9Z8rmjzphhzeBtpeA==" });

            migrationBuilder.UpdateData(
                table: "KorisniciUloge",
                keyColumn: "KorisnikUlogaId",
                keyValue: 1,
                column: "DatumIzmjene",
                value: new DateTime(2025, 2, 21, 17, 57, 0, 576, DateTimeKind.Local).AddTicks(1921));

            migrationBuilder.UpdateData(
                table: "KorisniciUloge",
                keyColumn: "KorisnikUlogaId",
                keyValue: 2,
                column: "DatumIzmjene",
                value: new DateTime(2025, 2, 21, 17, 57, 0, 576, DateTimeKind.Local).AddTicks(1967));

            migrationBuilder.UpdateData(
                table: "Narudzba",
                keyColumn: "Id",
                keyValue: 6000,
                column: "DatumNarudzbe",
                value: new DateTime(2025, 2, 21, 17, 57, 0, 576, DateTimeKind.Local).AddTicks(2642));
        }
    }
}
