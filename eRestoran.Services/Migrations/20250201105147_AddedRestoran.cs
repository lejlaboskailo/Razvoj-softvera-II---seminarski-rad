using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace eRestoran.Services.Migrations
{
    /// <inheritdoc />
    public partial class AddedRestoran : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<int>(
                name: "DrzavaId",
                table: "Grad",
                type: "int",
                nullable: true);

            migrationBuilder.UpdateData(
                table: "Grad",
                keyColumn: "Id",
                keyValue: 3000,
                column: "DrzavaId",
                value: null);

            migrationBuilder.UpdateData(
                table: "Korisnici",
                keyColumn: "Id",
                keyValue: 1001,
                columns: new[] { "LozinkaHash", "LozinkaSalt" },
                values: new object[] { "XUKmJuYc7JrjnFCtYlReKEoaasQ=", "8tnP9m3/ho7v3Cr62iuEXw==" });

            migrationBuilder.UpdateData(
                table: "Korisnici",
                keyColumn: "Id",
                keyValue: 1002,
                columns: new[] { "LozinkaHash", "LozinkaSalt" },
                values: new object[] { "4lTI/onrz75Vrxc2PjDur5S+mb8=", "JcClOXD4+rGmXUPzFTlw2w==" });

            migrationBuilder.UpdateData(
                table: "Korisnici",
                keyColumn: "Id",
                keyValue: 1007,
                columns: new[] { "LozinkaHash", "LozinkaSalt" },
                values: new object[] { "qB4H5WD/lXxJ9cSUO45kamB1Ex8=", "4Du5zc/ik2K6TYaiHW08Xg==" });

            migrationBuilder.UpdateData(
                table: "KorisniciUloge",
                keyColumn: "KorisnikUlogaId",
                keyValue: 1,
                column: "DatumIzmjene",
                value: new DateTime(2025, 2, 1, 11, 51, 47, 102, DateTimeKind.Local).AddTicks(259));

            migrationBuilder.UpdateData(
                table: "KorisniciUloge",
                keyColumn: "KorisnikUlogaId",
                keyValue: 2,
                column: "DatumIzmjene",
                value: new DateTime(2025, 2, 1, 11, 51, 47, 102, DateTimeKind.Local).AddTicks(306));

            migrationBuilder.UpdateData(
                table: "Narudzba",
                keyColumn: "Id",
                keyValue: 6000,
                column: "DatumNarudzbe",
                value: new DateTime(2025, 2, 1, 11, 51, 47, 102, DateTimeKind.Local).AddTicks(878));

            migrationBuilder.CreateIndex(
                name: "IX_Grad_DrzavaId",
                table: "Grad",
                column: "DrzavaId");

            migrationBuilder.AddForeignKey(
                name: "FK_Grad_Drzava_DrzavaId",
                table: "Grad",
                column: "DrzavaId",
                principalTable: "Drzava",
                principalColumn: "Id");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Grad_Drzava_DrzavaId",
                table: "Grad");

            migrationBuilder.DropIndex(
                name: "IX_Grad_DrzavaId",
                table: "Grad");

            migrationBuilder.DropColumn(
                name: "DrzavaId",
                table: "Grad");

            migrationBuilder.UpdateData(
                table: "Korisnici",
                keyColumn: "Id",
                keyValue: 1001,
                columns: new[] { "LozinkaHash", "LozinkaSalt" },
                values: new object[] { "rKyDjgN+Ay/JC5JpvpobXB9HRGw=", "dfDUv7ow/3ijB3mMkq3waw==" });

            migrationBuilder.UpdateData(
                table: "Korisnici",
                keyColumn: "Id",
                keyValue: 1002,
                columns: new[] { "LozinkaHash", "LozinkaSalt" },
                values: new object[] { "18C/NPVCC5QuQPcQLCmPaYpsi6U=", "lerO4ZCyhDFiUdkxhkUj+A==" });

            migrationBuilder.UpdateData(
                table: "Korisnici",
                keyColumn: "Id",
                keyValue: 1007,
                columns: new[] { "LozinkaHash", "LozinkaSalt" },
                values: new object[] { "miQeTaWOrTx5VM+UVTb98Iqedd8=", "EAXCe2XSAvALjnx/fS4cjg==" });

            migrationBuilder.UpdateData(
                table: "KorisniciUloge",
                keyColumn: "KorisnikUlogaId",
                keyValue: 1,
                column: "DatumIzmjene",
                value: new DateTime(2025, 1, 20, 15, 25, 13, 853, DateTimeKind.Local).AddTicks(6637));

            migrationBuilder.UpdateData(
                table: "KorisniciUloge",
                keyColumn: "KorisnikUlogaId",
                keyValue: 2,
                column: "DatumIzmjene",
                value: new DateTime(2025, 1, 20, 15, 25, 13, 853, DateTimeKind.Local).AddTicks(6687));

            migrationBuilder.UpdateData(
                table: "Narudzba",
                keyColumn: "Id",
                keyValue: 6000,
                column: "DatumNarudzbe",
                value: new DateTime(2025, 1, 20, 15, 25, 13, 853, DateTimeKind.Local).AddTicks(7269));
        }
    }
}
