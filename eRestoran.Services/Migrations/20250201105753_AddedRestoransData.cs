using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace eRestoran.Services.Migrations
{
    /// <inheritdoc />
    public partial class AddedRestoransData : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.CreateTable(
                name: "Restorans",
                columns: table => new
                {
                    RestoranId = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    NazivRestorana = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    Email = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    Telefon = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    Adresa = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    GradId = table.Column<int>(type: "int", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Restorans", x => x.RestoranId);
                    table.ForeignKey(
                        name: "FK_Restorans_Grad_GradId",
                        column: x => x.GradId,
                        principalTable: "Grad",
                        principalColumn: "Id");
                });

            migrationBuilder.UpdateData(
                table: "Grad",
                keyColumn: "Id",
                keyValue: 3000,
                column: "DrzavaId",
                value: 2000);

            migrationBuilder.UpdateData(
                table: "Korisnici",
                keyColumn: "Id",
                keyValue: 1001,
                columns: new[] { "LozinkaHash", "LozinkaSalt" },
                values: new object[] { "lTWpvsjfuwMZMehqkzgjHPxvBl8=", "a61Mdb80idWHRwAx8NpXSg==" });

            migrationBuilder.UpdateData(
                table: "Korisnici",
                keyColumn: "Id",
                keyValue: 1002,
                columns: new[] { "LozinkaHash", "LozinkaSalt" },
                values: new object[] { "SbROkw6mA2O9TyBLeQ4VkXxfW0E=", "EvDmkUmlUA4XVaphUD3fOA==" });

            migrationBuilder.UpdateData(
                table: "Korisnici",
                keyColumn: "Id",
                keyValue: 1007,
                columns: new[] { "LozinkaHash", "LozinkaSalt" },
                values: new object[] { "j9XzxSJhWy5qnu4lhGqEHzcQYb8=", "5DaQwla5EPPPLgokthLH5Q==" });

            migrationBuilder.UpdateData(
                table: "KorisniciUloge",
                keyColumn: "KorisnikUlogaId",
                keyValue: 1,
                column: "DatumIzmjene",
                value: new DateTime(2025, 2, 1, 11, 57, 53, 32, DateTimeKind.Local).AddTicks(7057));

            migrationBuilder.UpdateData(
                table: "KorisniciUloge",
                keyColumn: "KorisnikUlogaId",
                keyValue: 2,
                column: "DatumIzmjene",
                value: new DateTime(2025, 2, 1, 11, 57, 53, 32, DateTimeKind.Local).AddTicks(7100));

            migrationBuilder.UpdateData(
                table: "Narudzba",
                keyColumn: "Id",
                keyValue: 6000,
                column: "DatumNarudzbe",
                value: new DateTime(2025, 2, 1, 11, 57, 53, 32, DateTimeKind.Local).AddTicks(7676));

            migrationBuilder.InsertData(
                table: "Restorans",
                columns: new[] { "RestoranId", "Adresa", "Email", "GradId", "NazivRestorana", "Telefon" },
                values: new object[] { 3111, "Mostar", "restoran@gmail.com", 3000, "eRestoran", "066111111" });

            migrationBuilder.CreateIndex(
                name: "IX_Restorans_GradId",
                table: "Restorans",
                column: "GradId");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "Restorans");

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
        }
    }
}
