using AutoMapper;
using eRestoran.Model;
using eRestoran.Model.Requests;
using eRestoran.Services;
using eRestoran.Model.SearchObjects;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eRestoran.Services.Mapping
{
    public class ProfileMapping : Profile
    {
        public ProfileMapping()
        {

            CreateMap<Database.Dojmovi, Model.Dojmovi>();
            CreateMap<DojmoviSearchObject,Database.Dojmovi>();
            CreateMap<DojmoviInsertRequest, Database.Dojmovi>();
            CreateMap<DojmoviUpsertRequest, Database.Dojmovi>();


            CreateMap<Database.KorisniciUloge, Model.KorisniciUloge>();
            CreateMap<KorisniciUlogaSearchRequest, Database.KorisniciUloge>();
            CreateMap<KorisniciUlogeInsertRequest, Database.KorisniciUloge>();
            CreateMap<KorisniciUlogeUpdateRequest, Database.KorisniciUloge>();

            CreateMap<Database.Drzava, Model.Drzava>();
            CreateMap<DojmoviSearchObject, Database.Dojmovi>();

            CreateMap<Database.Korisnici, Model.Korisnik>().ReverseMap();

            CreateMap<KorisnikSearchRequests, Database.Korisnici>();
            CreateMap<KorisnikInsertRequest, Database.Korisnici>();
            CreateMap<KorisnikUpsertRequest, Database.Korisnici>();

            CreateMap<Database.KorisniciUloge, Model.KorisniciUloge>();
            CreateMap<Database.Uloge, Model.Uloge>();

            CreateMap<Database.Grad, Model.Grad>();
            CreateMap<GradSearchObject, Database.Grad>();

            CreateMap<Database.Restoran, Model.Restoran>();

            CreateMap<Database.Jelo,Model.Jelo>();
            CreateMap<JeloSearchObject, Database.Jelo>();
            CreateMap<JeloUpsertRequest, Database.Jelo>();
            CreateMap<JeloUpsertRequest, Database.Jelo>();

            CreateMap<Database.Kategorija, Model.Kategorija>();
            CreateMap<KategorijaSearchRequest, Database.Kategorija>();
            CreateMap<KategorijaInsertRequest, Database.Kategorija>();
            CreateMap<KategorijaUpdateRequest, Database.Kategorija>();

            CreateMap<Database.Narudzba, Model.Narudzba>();
            CreateMap<NarudzbaSearchObject, Database.Narudzba>();
            CreateMap<NarudzbaInsertRequest, Database.Narudzba>();
            CreateMap<NarudzbaUpdateRequest,Database.Narudzba>();

            CreateMap<Database.Status, Model.StatusNarudzbe>();
            CreateMap<StatusNarudzbeSearchObject, Database.Status>();

            CreateMap<Database.StavkeNarudzbe, Model.StavkeNarudzbe>();
            CreateMap<StavkeNarudzbeSearchObject,Services.Database.StavkeNarudzbe>();
            CreateMap<StavkeNarudzbeSearchObject, Services.Database.StavkeNarudzbe>();
            CreateMap<StavkeNarudzbeUpdateRequest, Services.Database.StavkeNarudzbe>();

            CreateMap<Database.Uplatum, Model.Uplata>();
            CreateMap<UplataSearchObject, Database.Uplatum>();
            CreateMap<UplataInsertRequest, Database.Uplatum>();
            CreateMap<UplateUpdateRequest,Database.Uplatum>();

            



        }
    }
}
