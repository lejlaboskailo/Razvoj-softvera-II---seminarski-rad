using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace eRestoran.Services.Migrations
{
    /// <inheritdoc />
    public partial class addKorpa : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "StateMachine",
                table: "Jelo");

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
                value: 1007);

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
                table: "Korisnici",
                keyColumn: "Id",
                keyValue: 1001,
                columns: new[] { "LozinkaHash", "LozinkaSalt" },
                values: new object[] { "3JMY8VIVI+RDZ5i44F0ajT8XQCg=", "47Qv4x7nEEgmHAatqaDQNA==" });

            migrationBuilder.UpdateData(
                table: "Korisnici",
                keyColumn: "Id",
                keyValue: 1002,
                columns: new[] { "LozinkaHash", "LozinkaSalt" },
                values: new object[] { "gt4wk2uUHYD26Hfl7JhQU49KQqo=", "jX//WL0VYCrci8u/zogQPQ==" });

            migrationBuilder.UpdateData(
                table: "Korisnici",
                keyColumn: "Id",
                keyValue: 1007,
                columns: new[] { "LozinkaHash", "LozinkaSalt" },
                values: new object[] { "Wt/ragYFzLijaT+1tPaEN23kGRQ=", "os0p2CkkJOOCcqa0PopFkA==" });

            migrationBuilder.UpdateData(
                table: "KorisniciUloge",
                keyColumn: "KorisnikUlogaId",
                keyValue: 1,
                column: "DatumIzmjene",
                value: new DateTime(2025, 2, 21, 18, 58, 15, 584, DateTimeKind.Local).AddTicks(8182));

            migrationBuilder.UpdateData(
                table: "KorisniciUloge",
                keyColumn: "KorisnikUlogaId",
                keyValue: 2,
                column: "DatumIzmjene",
                value: new DateTime(2025, 2, 21, 18, 58, 15, 584, DateTimeKind.Local).AddTicks(8231));

            migrationBuilder.UpdateData(
                table: "Narudzba",
                keyColumn: "Id",
                keyValue: 6000,
                column: "DatumNarudzbe",
                value: new DateTime(2025, 2, 21, 18, 58, 15, 584, DateTimeKind.Local).AddTicks(8969));
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<string>(
                name: "StateMachine",
                table: "Jelo",
                type: "nvarchar(max)",
                nullable: true);

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
    }
}
