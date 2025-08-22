using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

#pragma warning disable CA1814 // Prefer jagged arrays over multidimensional

namespace eRestoran.Services.Migrations
{
    /// <inheritdoc />
    public partial class PriloziAdd : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<int>(
                name: "PrilogId",
                table: "Korpa",
                type: "int",
                nullable: true);

            migrationBuilder.AddColumn<int>(
                name: "PriloziPrilogId",
                table: "Korpa",
                type: "int",
                nullable: true);

            migrationBuilder.CreateTable(
                name: "Prilozi",
                columns: table => new
                {
                    PrilogId = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    NazivPriloga = table.Column<string>(type: "nvarchar(50)", maxLength: 50, nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK__Prilozi__3214EC07EA4B5287", x => x.PrilogId);
                });

            migrationBuilder.UpdateData(
                table: "Korisnici",
                keyColumn: "Id",
                keyValue: 1001,
                columns: new[] { "LozinkaHash", "LozinkaSalt" },
                values: new object[] { "SqiPllYB9Z2RdP0gL4/OWLCwYrU=", "GTncutrDS+BZxBEUVcK55A==" });

            migrationBuilder.UpdateData(
                table: "Korisnici",
                keyColumn: "Id",
                keyValue: 1002,
                columns: new[] { "LozinkaHash", "LozinkaSalt" },
                values: new object[] { "HpDgDZH5zZHJP7LrijAjlDkcaDE=", "wm9yqPvQMiqo4mGGtVNyAA==" });

            migrationBuilder.UpdateData(
                table: "Korisnici",
                keyColumn: "Id",
                keyValue: 1007,
                columns: new[] { "LozinkaHash", "LozinkaSalt" },
                values: new object[] { "79gLCwYrfLmHZhZ8l5LSlAYK3Jg=", "bertlW75J+p2zYolA7FwXQ==" });

            migrationBuilder.UpdateData(
                table: "KorisniciUloge",
                keyColumn: "KorisnikUlogaId",
                keyValue: 1,
                column: "DatumIzmjene",
                value: new DateTime(2025, 8, 22, 21, 21, 2, 497, DateTimeKind.Local).AddTicks(8343));

            migrationBuilder.UpdateData(
                table: "KorisniciUloge",
                keyColumn: "KorisnikUlogaId",
                keyValue: 2,
                column: "DatumIzmjene",
                value: new DateTime(2025, 8, 22, 21, 21, 2, 497, DateTimeKind.Local).AddTicks(8390));

            migrationBuilder.UpdateData(
                table: "Korpa",
                keyColumn: "KorpaId",
                keyValue: 7898,
                columns: new[] { "PrilogId", "PriloziPrilogId" },
                values: new object[] { null, null });

            migrationBuilder.UpdateData(
                table: "Narudzba",
                keyColumn: "Id",
                keyValue: 6000,
                column: "DatumNarudzbe",
                value: new DateTime(2025, 8, 22, 21, 21, 2, 497, DateTimeKind.Local).AddTicks(8980));

            migrationBuilder.InsertData(
                table: "Prilozi",
                columns: new[] { "PrilogId", "NazivPriloga" },
                values: new object[,]
                {
                    { 4878, "Senf" },
                    { 4898, "Majoneza" }
                });

            migrationBuilder.CreateIndex(
                name: "IX_Korpa_PriloziPrilogId",
                table: "Korpa",
                column: "PriloziPrilogId");

            migrationBuilder.AddForeignKey(
                name: "FK_Korpa_Prilozi_PriloziPrilogId",
                table: "Korpa",
                column: "PriloziPrilogId",
                principalTable: "Prilozi",
                principalColumn: "PrilogId");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Korpa_Prilozi_PriloziPrilogId",
                table: "Korpa");

            migrationBuilder.DropTable(
                name: "Prilozi");

            migrationBuilder.DropIndex(
                name: "IX_Korpa_PriloziPrilogId",
                table: "Korpa");

            migrationBuilder.DropColumn(
                name: "PrilogId",
                table: "Korpa");

            migrationBuilder.DropColumn(
                name: "PriloziPrilogId",
                table: "Korpa");

            migrationBuilder.UpdateData(
                table: "Korisnici",
                keyColumn: "Id",
                keyValue: 1001,
                columns: new[] { "LozinkaHash", "LozinkaSalt" },
                values: new object[] { "Qz5/doEl9OaGQHEhxwC+chbod4M=", "sb+FwPfsitze8EnDgbM0UA==" });

            migrationBuilder.UpdateData(
                table: "Korisnici",
                keyColumn: "Id",
                keyValue: 1002,
                columns: new[] { "LozinkaHash", "LozinkaSalt" },
                values: new object[] { "10l5eavGck0WODVFTB9Qc9KzGLU=", "gF1GUhqllH1u5+6khUlyag==" });

            migrationBuilder.UpdateData(
                table: "Korisnici",
                keyColumn: "Id",
                keyValue: 1007,
                columns: new[] { "LozinkaHash", "LozinkaSalt" },
                values: new object[] { "tbPLKjSZxbJEGV3chgd0qkymXsQ=", "x5mxETGD7DDP20fvavhlyg==" });

            migrationBuilder.UpdateData(
                table: "KorisniciUloge",
                keyColumn: "KorisnikUlogaId",
                keyValue: 1,
                column: "DatumIzmjene",
                value: new DateTime(2025, 8, 22, 17, 26, 47, 686, DateTimeKind.Local).AddTicks(7551));

            migrationBuilder.UpdateData(
                table: "KorisniciUloge",
                keyColumn: "KorisnikUlogaId",
                keyValue: 2,
                column: "DatumIzmjene",
                value: new DateTime(2025, 8, 22, 17, 26, 47, 686, DateTimeKind.Local).AddTicks(7598));

            migrationBuilder.UpdateData(
                table: "Narudzba",
                keyColumn: "Id",
                keyValue: 6000,
                column: "DatumNarudzbe",
                value: new DateTime(2025, 8, 22, 17, 26, 47, 686, DateTimeKind.Local).AddTicks(8337));
        }
    }
}
