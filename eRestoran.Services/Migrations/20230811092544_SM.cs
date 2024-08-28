using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace eRestoran.Services.Migrations
{
    /// <inheritdoc />
    public partial class SM : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.CreateTable(
                name: "Drzava",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Naziv = table.Column<string>(type: "nvarchar(20)", maxLength: 20, nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK__Drzava__3214EC076CFB6820", x => x.Id);
                });

            migrationBuilder.CreateTable(
                name: "Grad",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Naziv = table.Column<string>(type: "nvarchar(50)", maxLength: 50, nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK__Grad__3214EC07EA4B5287", x => x.Id);
                });

            migrationBuilder.CreateTable(
                name: "Kategorija",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Naziv = table.Column<string>(type: "nvarchar(50)", maxLength: 50, nullable: true),
                    Opis = table.Column<string>(type: "nvarchar(100)", maxLength: 100, nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK__Kategori__3214EC070A4F4900", x => x.Id);
                });

            migrationBuilder.CreateTable(
                name: "Status",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Naziv = table.Column<string>(type: "nvarchar(50)", maxLength: 50, nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK__Status__3214EC071A49A4A8", x => x.Id);
                });

            migrationBuilder.CreateTable(
                name: "Uloge",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Naziv = table.Column<string>(type: "nvarchar(100)", maxLength: 100, nullable: true),
                    Opis = table.Column<string>(type: "nvarchar(100)", maxLength: 100, nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK__Uloge__3214EC076C332449", x => x.Id);
                });

            migrationBuilder.CreateTable(
                name: "Korisnici",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Ime = table.Column<string>(type: "nvarchar(100)", maxLength: 100, nullable: true),
                    Prezime = table.Column<string>(type: "nvarchar(100)", maxLength: 100, nullable: true),
                    GradId = table.Column<int>(type: "int", nullable: true),
                    DrzavaId = table.Column<int>(type: "int", nullable: true),
                    KorisnickoIme = table.Column<string>(type: "nvarchar(100)", maxLength: 100, nullable: true),
                    LozinkaHash = table.Column<string>(type: "nvarchar(50)", maxLength: 50, nullable: true),
                    LozinkaSalt = table.Column<string>(type: "nvarchar(1)", maxLength: 1, nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK__Korisnic__3214EC07033A56BF", x => x.Id);
                    table.ForeignKey(
                        name: "FK__Korisnici__Drzav__29572725",
                        column: x => x.DrzavaId,
                        principalTable: "Drzava",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK__Korisnici__GradI__286302EC",
                        column: x => x.GradId,
                        principalTable: "Grad",
                        principalColumn: "Id");
                });

            migrationBuilder.CreateTable(
                name: "Jelo",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Naziv = table.Column<string>(type: "nvarchar(100)", maxLength: 100, nullable: true),
                    Opis = table.Column<string>(type: "nvarchar(100)", maxLength: 100, nullable: true),
                    Cijena = table.Column<decimal>(type: "money", nullable: true),
                    KategorijaId = table.Column<int>(type: "int", nullable: true),
                    Slika = table.Column<string>(type: "nvarchar(max)", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK__Jelo__3214EC0766C6F668", x => x.Id);
                    table.ForeignKey(
                        name: "FK__Jelo__Kategorija__2E1BDC42",
                        column: x => x.KategorijaId,
                        principalTable: "Kategorija",
                        principalColumn: "Id");
                });

            migrationBuilder.CreateTable(
                name: "KorisniciUloge",
                columns: table => new
                {
                    KorisnikUlogaId = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    KorisnikId = table.Column<int>(type: "int", nullable: false),
                    UlogaId = table.Column<int>(type: "int", nullable: false),
                    DatumIzmjene = table.Column<DateTime>(type: "datetime", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK__Korisnic__1608726E77415232", x => x.KorisnikUlogaId);
                    table.ForeignKey(
                        name: "FK__Korisnici__Koris__4316F928",
                        column: x => x.KorisnikId,
                        principalTable: "Korisnici",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK__Korisnici__Uloga__440B1D61",
                        column: x => x.UlogaId,
                        principalTable: "Uloge",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "Narudzba",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    DatumNarudzbe = table.Column<DateTime>(type: "datetime", nullable: true),
                    KorisnikId = table.Column<int>(type: "int", nullable: true),
                    StatusNarudzbeId = table.Column<int>(type: "int", nullable: true),
                    StateMachine = table.Column<string>(type: "nvarchar(max)", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK__Narudzba__3214EC07423966FD", x => x.Id);
                    table.ForeignKey(
                        name: "FK__Narudzba__Korisn__32E0915F",
                        column: x => x.KorisnikId,
                        principalTable: "Korisnici",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK__Narudzba__Status__33D4B598",
                        column: x => x.StatusNarudzbeId,
                        principalTable: "Status",
                        principalColumn: "Id");
                });

            migrationBuilder.CreateTable(
                name: "Uplata",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Iznos = table.Column<decimal>(type: "money", nullable: true),
                    DatumTransakcije = table.Column<DateTime>(type: "datetime", nullable: true),
                    BrojTransakcije = table.Column<string>(type: "nvarchar(1)", maxLength: 1, nullable: true),
                    KorisnikId = table.Column<int>(type: "int", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK__Uplata__3214EC07C865A4BE", x => x.Id);
                    table.ForeignKey(
                        name: "FK__Uplata__Korisnik__3E52440B",
                        column: x => x.KorisnikId,
                        principalTable: "Korisnici",
                        principalColumn: "Id");
                });

            migrationBuilder.CreateTable(
                name: "Dojmovi",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Ocjena = table.Column<int>(type: "int", nullable: true),
                    Opis = table.Column<string>(type: "nvarchar(100)", maxLength: 100, nullable: true),
                    JeloId = table.Column<int>(type: "int", nullable: true),
                    KorisnikId = table.Column<int>(type: "int", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK__Dojmovi__3214EC078DD4709C", x => x.Id);
                    table.ForeignKey(
                        name: "FK__Dojmovi__JeloId__36B12243",
                        column: x => x.JeloId,
                        principalTable: "Jelo",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK__Dojmovi__Korisni__37A5467C",
                        column: x => x.KorisnikId,
                        principalTable: "Korisnici",
                        principalColumn: "Id");
                });

            migrationBuilder.CreateTable(
                name: "StavkeNarudzbe",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Kolicina = table.Column<int>(type: "int", nullable: true),
                    Cijena = table.Column<int>(type: "int", nullable: true),
                    JeloId = table.Column<int>(type: "int", nullable: true),
                    NarudzbaId = table.Column<int>(type: "int", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK__StavkeNa__3214EC0781E952BB", x => x.Id);
                    table.ForeignKey(
                        name: "FK__StavkeNar__JeloI__3A81B327",
                        column: x => x.JeloId,
                        principalTable: "Jelo",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK__StavkeNar__Narud__3B75D760",
                        column: x => x.NarudzbaId,
                        principalTable: "Narudzba",
                        principalColumn: "Id");
                });

            migrationBuilder.CreateIndex(
                name: "IX_Dojmovi_JeloId",
                table: "Dojmovi",
                column: "JeloId");

            migrationBuilder.CreateIndex(
                name: "IX_Dojmovi_KorisnikId",
                table: "Dojmovi",
                column: "KorisnikId");

            migrationBuilder.CreateIndex(
                name: "IX_Jelo_KategorijaId",
                table: "Jelo",
                column: "KategorijaId");

            migrationBuilder.CreateIndex(
                name: "IX_Korisnici_DrzavaId",
                table: "Korisnici",
                column: "DrzavaId");

            migrationBuilder.CreateIndex(
                name: "IX_Korisnici_GradId",
                table: "Korisnici",
                column: "GradId");

            migrationBuilder.CreateIndex(
                name: "IX_KorisniciUloge_KorisnikId",
                table: "KorisniciUloge",
                column: "KorisnikId");

            migrationBuilder.CreateIndex(
                name: "IX_KorisniciUloge_UlogaId",
                table: "KorisniciUloge",
                column: "UlogaId");

            migrationBuilder.CreateIndex(
                name: "IX_Narudzba_KorisnikId",
                table: "Narudzba",
                column: "KorisnikId");

            migrationBuilder.CreateIndex(
                name: "IX_Narudzba_StatusNarudzbeId",
                table: "Narudzba",
                column: "StatusNarudzbeId");

            migrationBuilder.CreateIndex(
                name: "IX_StavkeNarudzbe_JeloId",
                table: "StavkeNarudzbe",
                column: "JeloId");

            migrationBuilder.CreateIndex(
                name: "IX_StavkeNarudzbe_NarudzbaId",
                table: "StavkeNarudzbe",
                column: "NarudzbaId");

            migrationBuilder.CreateIndex(
                name: "IX_Uplata_KorisnikId",
                table: "Uplata",
                column: "KorisnikId");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "Dojmovi");

            migrationBuilder.DropTable(
                name: "KorisniciUloge");

            migrationBuilder.DropTable(
                name: "StavkeNarudzbe");

            migrationBuilder.DropTable(
                name: "Uplata");

            migrationBuilder.DropTable(
                name: "Uloge");

            migrationBuilder.DropTable(
                name: "Jelo");

            migrationBuilder.DropTable(
                name: "Narudzba");

            migrationBuilder.DropTable(
                name: "Kategorija");

            migrationBuilder.DropTable(
                name: "Korisnici");

            migrationBuilder.DropTable(
                name: "Status");

            migrationBuilder.DropTable(
                name: "Drzava");

            migrationBuilder.DropTable(
                name: "Grad");
        }
    }
}
