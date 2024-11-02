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

            CreateMap<Database.Drzava, Model.Drzava>();
            CreateMap<DojmoviSearchObject, Database.Dojmovi>();

            CreateMap<Database.Korisnici, Model.Korisnik>();
            CreateMap<KorisnikSearchRequests, Database.Korisnici>();
            CreateMap<KorisnikInsertRequest, Database.Korisnici>();
            CreateMap<KorisnikUpsertRequest, Database.Korisnici>();

            CreateMap<Database.KorisniciUloge, Model.KorisniciUloge>();
            CreateMap<Database.Uloge, Model.Uloge>();

            CreateMap<Database.Grad, Model.Grad>();
            CreateMap<GradSearchObject, Database.Grad>();

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

            


            /* CreateMap<eRestoran.Services.Database.Drzava, eRestoran.Model.Drzava>();
             CreateMap<eRestoran.Services.Database.Grad, eRestoran.Model.Grad>();
             CreateMap<eRestoran.Services.Database.Korisnici, eRestoran.Model.Korisnik>();
             CreateMap<eRestoran.Services.Database.Uloge, eRestoran.Model.Uloge>();
             CreateMap<eRestoran.Services.Database.KorisniciUloge, eRestoran.Model.KorisnikUloge>();
             CreateMap<eRestoran.Services.Database.Kategorija, eRestoran.Model.Kategorija>();
             CreateMap<eRestoran.Services.Database.Status, eRestoran.Model.StatusNarudzbe>();
             CreateMap<StatusNarudzbeSearchObject, Model.StatusNarudzbe>();

             CreateMap<eRestoran.Services.Database.StavkeNarudzbe, Model.StavkeNarudzbe>();
             CreateMap<StavkeNarudzbeSearchObject, Model.StavkeNarudzbe>();
             CreateMap<StavkeNarudzbeUpsertRequest, eRestoran.Services.Database.StavkeNarudzbe>();
             CreateMap<StavkeNarudzbeUpsertRequest, eRestoran.Services.Database.StavkeNarudzbe>();

             CreateMap<eRestoran.Services.Database.Narudzba, Model.Narudzba>();
             CreateMap<NarudzbaSearchObject, Model.Narudzba>();
             CreateMap<NarudzbaUpsertRequest, eRestoran.Services.Database.Narudzba>();

             CreateMap<eRestoran.Services.Database.Jelo, Model.Jelo>();
             CreateMap<JeloSearchObject, eRestoran.Services.Database.Jelo>();*/

            /*CreateMap<eRestoran.Services.Database.Jelo, Model.Jelo>()
                .ForMember(x => x.Kategorija, db => db.MapFrom(src => src.Kategorija.Naziv))
                .ReverseMap*/
            /*CreateMap<JeloUpsertRequest, eRestoran.Services.Database.Jelo>();

            CreateMap<eRestoran.Model.Requests.KategorijaUpsertRequest, eRestoran.Services.Database.Kategorija>();

            CreateMap<eRestoran.Model.Requests.KorisnikUpsertRequest, eRestoran.Services.Database.Korisnici>();
            CreateMap<eRestoran.Model.Requests.KorisnikUpsertRequest, eRestoran.Services.Database.Korisnici>();
            CreateMap<eRestoran.Services.Database.Dojmovi, Model.Dojmovi>();
            CreateMap<DojmoviUpsertRequest, eRestoran.Services.Database.Dojmovi>();
            CreateMap<KorisnikUpsertRequest, eRestoran.Model.Korisnik>();

            CreateMap<eRestoran.Services.Database.Uplatum, Model.Uplata>();
            CreateMap<eRestoran.Model.Requests.UplataUpsertRequest, eRestoran.Services.Database.Uplatum>();*/

        }
    }
}
