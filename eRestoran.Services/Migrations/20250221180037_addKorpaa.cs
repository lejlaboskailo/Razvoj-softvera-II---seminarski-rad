using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

#pragma warning disable CA1814 // Prefer jagged arrays over multidimensional

namespace eRestoran.Services.Migrations
{
    /// <inheritdoc />
    public partial class addKorpaa : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
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
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
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
    }
}
