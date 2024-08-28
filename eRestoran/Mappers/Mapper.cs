using AutoMapper;
using eRestoran.Model.Requests;
using eRestoran.Model.SearchObjects;
using eRestoran.Services;

namespace eRestoran.Mappers
{
    public class Mapper:Profile
    {
        public Mapper() 
        {

            
            CreateMap<eRestoran.Services.Database.Drzava,eRestoran.Model.Drzava>();
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
            
            CreateMap<eRestoran.Services.Database.Narudzba, Model.Narudzba>()
                .ForMember(x => x.Korisnik, db => db.MapFrom(src => src.Korisnik.Ime + " " + src.Korisnik.Prezime))
                .ForMember(x => x.StatusNarudzbe, db => db.MapFrom(src => src.StatusNarudzbe.Naziv));
            CreateMap<NarudzbaSearchObject, Model.Narudzba>();
            CreateMap<NarudzbaUpsertRequest, eRestoran.Services.Database.Narudzba>();

            CreateMap<eRestoran.Services.Database.Jelo, Model.Jelo>();
            CreateMap<JeloSearchObject, eRestoran.Services.Database.Jelo>();

            /*CreateMap<eRestoran.Services.Database.Jelo, Model.Jelo>()
                .ForMember(x => x.Kategorija, db => db.MapFrom(src => src.Kategorija.Naziv))
                .ReverseMap*/
            CreateMap<JeloUpsertRequest, eRestoran.Services.Database.Jelo>();

            CreateMap<eRestoran.Model.Requests.KategorijaUpsertRequest, eRestoran.Services.Database.Kategorija>();

            CreateMap<eRestoran.Model.Requests.KorisnikUpsertRequest, eRestoran.Services.Database.Korisnici>();
            CreateMap<eRestoran.Model.Requests.KorisnikUpsertRequest, eRestoran.Services.Database.Korisnici>().ForAllMembers(opts =>
            {
                opts.Condition((src, dest, srcMember) => srcMember != null);
            });
            CreateMap<eRestoran.Services.Database.Dojmovi, Model.Dojmovi>();
            CreateMap<DojmoviUpsertRequest, eRestoran.Services.Database.Dojmovi>();
            //CreateMap<KorisnikUpsertRequest, eRestoran.Model.Korisnik>();

            CreateMap<eRestoran.Services.Database.Uplatum, Model.Uplata>();
            CreateMap<eRestoran.Model.Requests.UplataUpsertRequest, eRestoran.Services.Database.Uplatum>();

        }
    }
}
