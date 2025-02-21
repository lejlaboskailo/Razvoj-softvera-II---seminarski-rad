using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace eRestoran.Services.Migrations
{
    /// <inheritdoc />
    public partial class addKorpaaa : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK__Dojmovi__JeloId__36B12243",
                table: "Dojmovi");

            migrationBuilder.DropForeignKey(
                name: "FK__Dojmovi__Korisni__37A5467C",
                table: "Dojmovi");

            migrationBuilder.UpdateData(
                table: "Korisnici",
                keyColumn: "Id",
                keyValue: 1001,
                columns: new[] { "LozinkaHash", "LozinkaSalt" },
                values: new object[] { "BjEe16wu1iYDepibmalXDrsXd1w=", "QoM/9ybJLvWT37duFgMC2w==" });

            migrationBuilder.UpdateData(
                table: "Korisnici",
                keyColumn: "Id",
                keyValue: 1002,
                columns: new[] { "LozinkaHash", "LozinkaSalt" },
                values: new object[] { "qes/o6s38/m4GrOBkuxyqV0QzLs=", "xR7RbjVJ8Rr4wL4zw4mznQ==" });

            migrationBuilder.UpdateData(
                table: "Korisnici",
                keyColumn: "Id",
                keyValue: 1007,
                columns: new[] { "LozinkaHash", "LozinkaSalt" },
                values: new object[] { "4MuOfgjmWj5TfX4pjSvH0BqbASI=", "JWuUhbE7le6ydq8QyX2Vyw==" });

            migrationBuilder.UpdateData(
                table: "KorisniciUloge",
                keyColumn: "KorisnikUlogaId",
                keyValue: 1,
                column: "DatumIzmjene",
                value: new DateTime(2025, 2, 21, 19, 3, 10, 674, DateTimeKind.Local).AddTicks(1948));

            migrationBuilder.UpdateData(
                table: "KorisniciUloge",
                keyColumn: "KorisnikUlogaId",
                keyValue: 2,
                column: "DatumIzmjene",
                value: new DateTime(2025, 2, 21, 19, 3, 10, 674, DateTimeKind.Local).AddTicks(1993));

            migrationBuilder.UpdateData(
                table: "Narudzba",
                keyColumn: "Id",
                keyValue: 6000,
                column: "DatumNarudzbe",
                value: new DateTime(2025, 2, 21, 19, 3, 10, 674, DateTimeKind.Local).AddTicks(2568));

            migrationBuilder.AddForeignKey(
                name: "FK__Dojmovi__JeloId__36B12243",
                table: "Dojmovi",
                column: "JeloId",
                principalTable: "Jelo",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK__Dojmovi__Korisni__37A5467C",
                table: "Dojmovi",
                column: "KorisnikId",
                principalTable: "Korisnici",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK__Dojmovi__JeloId__36B12243",
                table: "Dojmovi");

            migrationBuilder.DropForeignKey(
                name: "FK__Dojmovi__Korisni__37A5467C",
                table: "Dojmovi");

            migrationBuilder.UpdateData(
                table: "Korisnici",
                keyColumn: "Id",
                keyValue: 1001,
                columns: new[] { "LozinkaHash", "LozinkaSalt" },
                values: new object[] { "wsI1X/FYbNBSSYtL4YS+v91YeiE=", "OyPq+yeBdP3ANYBQo2it2A==" });

            migrationBuilder.UpdateData(
                table: "Korisnici",
                keyColumn: "Id",
                keyValue: 1002,
                columns: new[] { "LozinkaHash", "LozinkaSalt" },
                values: new object[] { "aiH09ToLnGXZM0D9zcRkfLK1wCU=", "M4zbHvCG/Ty3652eGZhEHQ==" });

            migrationBuilder.UpdateData(
                table: "Korisnici",
                keyColumn: "Id",
                keyValue: 1007,
                columns: new[] { "LozinkaHash", "LozinkaSalt" },
                values: new object[] { "g3CmZ9Qh1FsAOcwuFFT1DOLZYdo=", "6ece+iJRm0aMz3pccFsxxA==" });

            migrationBuilder.UpdateData(
                table: "KorisniciUloge",
                keyColumn: "KorisnikUlogaId",
                keyValue: 1,
                column: "DatumIzmjene",
                value: new DateTime(2025, 2, 21, 19, 0, 37, 72, DateTimeKind.Local).AddTicks(3109));

            migrationBuilder.UpdateData(
                table: "KorisniciUloge",
                keyColumn: "KorisnikUlogaId",
                keyValue: 2,
                column: "DatumIzmjene",
                value: new DateTime(2025, 2, 21, 19, 0, 37, 72, DateTimeKind.Local).AddTicks(3156));

            migrationBuilder.UpdateData(
                table: "Narudzba",
                keyColumn: "Id",
                keyValue: 6000,
                column: "DatumNarudzbe",
                value: new DateTime(2025, 2, 21, 19, 0, 37, 72, DateTimeKind.Local).AddTicks(3785));

            migrationBuilder.AddForeignKey(
                name: "FK__Dojmovi__JeloId__36B12243",
                table: "Dojmovi",
                column: "JeloId",
                principalTable: "Jelo",
                principalColumn: "Id");

            migrationBuilder.AddForeignKey(
                name: "FK__Dojmovi__Korisni__37A5467C",
                table: "Dojmovi",
                column: "KorisnikId",
                principalTable: "Korisnici",
                principalColumn: "Id");
        }
    }
}
