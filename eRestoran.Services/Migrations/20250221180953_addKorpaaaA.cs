using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

#pragma warning disable CA1814 // Prefer jagged arrays over multidimensional

namespace eRestoran.Services.Migrations
{
    /// <inheritdoc />
    public partial class addKorpaaaA : Migration
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

            migrationBuilder.InsertData(
                table: "Dojmovi",
                columns: new[] { "Id", "JeloId", "KorisnikId", "Ocjena", "Opis" },
                values: new object[,]
                {
                    { 8000, 5000, 1002, 5, "odlicna dostava" },
                    { 8001, 5000, 1002, 2, "odlicna dostava" },
                    { 8002, 5000, 1002, 2, "odlicna dostava" },
                    { 8003, 5000, 1002, 5, "odlicna dostava" },
                    { 8004, 5000, 1002, 3, "dostava ok" },
                    { 8005, 5000, 1002, 3, "dostava ok" },
                    { 8006, 5000, 1002, 2, "odlicna dostava" },
                    { 9007, 5000, 1001, 2, "odlicna dostava" },
                    { 9008, 5000, 1001, 2, "odlicna dostava" },
                    { 9009, 5000, 1001, 2, "odlicna dostava" },
                    { 9019, 5000, 1001, 3, "dostava" },
                    { 9100, 5000, 1001, 2, "odlicna dostava" },
                    { 9101, 5000, 1007, 5, "odlicna dostava" },
                    { 9102, 5000, 1007, 5, "odlicna dostava" },
                    { 9103, 5000, 1007, 2, "odlicna dostava" },
                    { 9106, 5001, 1001, 5, "odlicna dostava" },
                    { 9107, 5002, 1001, 2, "odlicna dostava" },
                    { 9108, 5004, 1002, 2, "odlicna dostava" },
                    { 9109, 5002, 1001, 4, "odlicna dostava" },
                    { 9110, 5002, 1002, 3, "odlicna dostava" },
                    { 9111, 5004, 1001, 2, "odlicna dostava" },
                    { 9112, 5005, 1001, 2, "odlicna dostava" },
                    { 9113, 5005, 1001, 3, "odlicna dostava" },
                    { 9114, 5005, 1002, 4, "odlicna dostava" },
                    { 9115, 5005, 1002, 2, "odlicna dostava" },
                    { 9116, 5005, 1007, 2, "odlicna dostava" },
                    { 9140, 5001, 1007, 5, "odlicna dostava" },
                    { 9150, 5001, 1007, 2, "odlicna dostava" },
                    { 9156, 5001, 1002, 2, "odlicna dostava" }
                });

            migrationBuilder.UpdateData(
                table: "Korisnici",
                keyColumn: "Id",
                keyValue: 1001,
                columns: new[] { "LozinkaHash", "LozinkaSalt" },
                values: new object[] { "arfusrTnDBWpzGY9a58X8r0XB34=", "wDFI4FWI8IouVpxKYyNytQ==" });

            migrationBuilder.UpdateData(
                table: "Korisnici",
                keyColumn: "Id",
                keyValue: 1002,
                columns: new[] { "LozinkaHash", "LozinkaSalt" },
                values: new object[] { "00ZkSRMAwGQUWSXIoPKmLo+lhFM=", "k0k50yAGozszmGblDRhMaQ==" });

            migrationBuilder.UpdateData(
                table: "Korisnici",
                keyColumn: "Id",
                keyValue: 1007,
                columns: new[] { "LozinkaHash", "LozinkaSalt" },
                values: new object[] { "fD9BE7uk8rHOfmO9pm+JwNRwDw0=", "HbCNrQ/zcjfP6F6u/l9PhQ==" });

            migrationBuilder.UpdateData(
                table: "KorisniciUloge",
                keyColumn: "KorisnikUlogaId",
                keyValue: 1,
                column: "DatumIzmjene",
                value: new DateTime(2025, 2, 21, 19, 9, 52, 937, DateTimeKind.Local).AddTicks(3504));

            migrationBuilder.UpdateData(
                table: "KorisniciUloge",
                keyColumn: "KorisnikUlogaId",
                keyValue: 2,
                column: "DatumIzmjene",
                value: new DateTime(2025, 2, 21, 19, 9, 52, 937, DateTimeKind.Local).AddTicks(3545));

            migrationBuilder.UpdateData(
                table: "Narudzba",
                keyColumn: "Id",
                keyValue: 6000,
                column: "DatumNarudzbe",
                value: new DateTime(2025, 2, 21, 19, 9, 52, 937, DateTimeKind.Local).AddTicks(4167));

            migrationBuilder.AddForeignKey(
                name: "FK__Dojmovi__JeloId__36B12243",
                table: "Dojmovi",
                column: "JeloId",
                principalTable: "Jelo",
                principalColumn: "Id",
                onDelete: ReferentialAction.SetNull);

            migrationBuilder.AddForeignKey(
                name: "FK__Dojmovi__Korisni__37A5467C",
                table: "Dojmovi",
                column: "KorisnikId",
                principalTable: "Korisnici",
                principalColumn: "Id",
                onDelete: ReferentialAction.SetNull);
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

            migrationBuilder.DeleteData(
                table: "Dojmovi",
                keyColumn: "Id",
                keyValue: 8000);

            migrationBuilder.DeleteData(
                table: "Dojmovi",
                keyColumn: "Id",
                keyValue: 8001);

            migrationBuilder.DeleteData(
                table: "Dojmovi",
                keyColumn: "Id",
                keyValue: 8002);

            migrationBuilder.DeleteData(
                table: "Dojmovi",
                keyColumn: "Id",
                keyValue: 8003);

            migrationBuilder.DeleteData(
                table: "Dojmovi",
                keyColumn: "Id",
                keyValue: 8004);

            migrationBuilder.DeleteData(
                table: "Dojmovi",
                keyColumn: "Id",
                keyValue: 8005);

            migrationBuilder.DeleteData(
                table: "Dojmovi",
                keyColumn: "Id",
                keyValue: 8006);

            migrationBuilder.DeleteData(
                table: "Dojmovi",
                keyColumn: "Id",
                keyValue: 9007);

            migrationBuilder.DeleteData(
                table: "Dojmovi",
                keyColumn: "Id",
                keyValue: 9008);

            migrationBuilder.DeleteData(
                table: "Dojmovi",
                keyColumn: "Id",
                keyValue: 9009);

            migrationBuilder.DeleteData(
                table: "Dojmovi",
                keyColumn: "Id",
                keyValue: 9019);

            migrationBuilder.DeleteData(
                table: "Dojmovi",
                keyColumn: "Id",
                keyValue: 9100);

            migrationBuilder.DeleteData(
                table: "Dojmovi",
                keyColumn: "Id",
                keyValue: 9101);

            migrationBuilder.DeleteData(
                table: "Dojmovi",
                keyColumn: "Id",
                keyValue: 9102);

            migrationBuilder.DeleteData(
                table: "Dojmovi",
                keyColumn: "Id",
                keyValue: 9103);

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
    }
}
