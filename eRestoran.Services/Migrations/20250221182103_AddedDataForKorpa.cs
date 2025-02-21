using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace eRestoran.Services.Migrations
{
    /// <inheritdoc />
    public partial class AddedDataForKorpa : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<string>(
                name: "StateMachine",
                table: "Jelo",
                type: "nvarchar(max)",
                nullable: true);

            migrationBuilder.CreateTable(
                name: "Korpa",
                columns: table => new
                {
                    KorpaId = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    ProizvodId = table.Column<int>(type: "int", nullable: false),
                    KorisnikId = table.Column<int>(type: "int", nullable: false),
                    Cijena = table.Column<decimal>(type: "decimal(18,2)", nullable: true),
                    KategorijaId = table.Column<int>(type: "int", nullable: true),
                    Kolicina = table.Column<int>(type: "int", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Korpa", x => x.KorpaId);
                });

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
                value: "cancelled");

            migrationBuilder.UpdateData(
                table: "Jelo",
                keyColumn: "Id",
                keyValue: 5005,
                column: "StateMachine",
                value: "active");

            migrationBuilder.UpdateData(
                table: "Korisnici",
                keyColumn: "Id",
                keyValue: 1001,
                columns: new[] { "LozinkaHash", "LozinkaSalt" },
                values: new object[] { "isLtrzhBA6qvWnmKh8e++l8/ODE=", "fMMIs1b9EUyzfs5uheV1ag==" });

            migrationBuilder.UpdateData(
                table: "Korisnici",
                keyColumn: "Id",
                keyValue: 1002,
                columns: new[] { "LozinkaHash", "LozinkaSalt" },
                values: new object[] { "KEpyIHWM4x5mAKfkdCAFHz5ZeD8=", "BTmuRcANjNXCV7rUIgeEDQ==" });

            migrationBuilder.UpdateData(
                table: "Korisnici",
                keyColumn: "Id",
                keyValue: 1007,
                columns: new[] { "LozinkaHash", "LozinkaSalt" },
                values: new object[] { "RL7TzCmx0k5t1MMmqYomGoL/Dug=", "wfL4EqX82tA1WVQErePpjQ==" });

            migrationBuilder.UpdateData(
                table: "KorisniciUloge",
                keyColumn: "KorisnikUlogaId",
                keyValue: 1,
                column: "DatumIzmjene",
                value: new DateTime(2025, 2, 21, 19, 21, 2, 983, DateTimeKind.Local).AddTicks(4626));

            migrationBuilder.UpdateData(
                table: "KorisniciUloge",
                keyColumn: "KorisnikUlogaId",
                keyValue: 2,
                column: "DatumIzmjene",
                value: new DateTime(2025, 2, 21, 19, 21, 2, 983, DateTimeKind.Local).AddTicks(4667));

            migrationBuilder.InsertData(
                table: "Korpa",
                columns: new[] { "KorpaId", "Cijena", "KategorijaId", "Kolicina", "KorisnikId", "ProizvodId" },
                values: new object[] { 7898, 30m, 4000, 2, 1002, 5000 });

            migrationBuilder.UpdateData(
                table: "Narudzba",
                keyColumn: "Id",
                keyValue: 6000,
                column: "DatumNarudzbe",
                value: new DateTime(2025, 2, 21, 19, 21, 2, 983, DateTimeKind.Local).AddTicks(5187));
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "Korpa");

            migrationBuilder.DropColumn(
                name: "StateMachine",
                table: "Jelo");

            migrationBuilder.UpdateData(
                table: "Korisnici",
                keyColumn: "Id",
                keyValue: 1001,
                columns: new[] { "LozinkaHash", "LozinkaSalt" },
                values: new object[] { "dcTcUtFbu5KifiJEvd1x5VVucdo=", "mb2+TuW+hTtQmX7+NE2LJw==" });

            migrationBuilder.UpdateData(
                table: "Korisnici",
                keyColumn: "Id",
                keyValue: 1002,
                columns: new[] { "LozinkaHash", "LozinkaSalt" },
                values: new object[] { "2snYotJKSy/jgsKwUhhDCnC6srU=", "23EQnBxCQsHZkqoEKoqrTQ==" });

            migrationBuilder.UpdateData(
                table: "Korisnici",
                keyColumn: "Id",
                keyValue: 1007,
                columns: new[] { "LozinkaHash", "LozinkaSalt" },
                values: new object[] { "sKQWSkx6U6lu+39IeiygzZbIdJo=", "G52C9TAgktywk7rQJqQaLA==" });

            migrationBuilder.UpdateData(
                table: "KorisniciUloge",
                keyColumn: "KorisnikUlogaId",
                keyValue: 1,
                column: "DatumIzmjene",
                value: new DateTime(2025, 2, 21, 19, 15, 7, 871, DateTimeKind.Local).AddTicks(8093));

            migrationBuilder.UpdateData(
                table: "KorisniciUloge",
                keyColumn: "KorisnikUlogaId",
                keyValue: 2,
                column: "DatumIzmjene",
                value: new DateTime(2025, 2, 21, 19, 15, 7, 871, DateTimeKind.Local).AddTicks(8138));

            migrationBuilder.UpdateData(
                table: "Narudzba",
                keyColumn: "Id",
                keyValue: 6000,
                column: "DatumNarudzbe",
                value: new DateTime(2025, 2, 21, 19, 15, 7, 871, DateTimeKind.Local).AddTicks(8666));
        }
    }
}
