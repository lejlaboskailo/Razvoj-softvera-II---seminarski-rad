using AutoMapper;
using eRestoran.Model.Requests;

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

            CreateMap<eRestoran.Model.Requests.KategorijaUpsertRequest, eRestoran.Services.Database.Kategorija>();

            CreateMap<eRestoran.Model.Requests.KorisnikUpsertRequest, eRestoran.Services.Database.Korisnici>();
            CreateMap<eRestoran.Model.Requests.KorisnikUpsertRequest, eRestoran.Services.Database.Korisnici>().ForAllMembers(opts =>
            {
                opts.Condition((src, dest, srcMember) => srcMember != null);
            });

            //CreateMap<KorisnikUpsertRequest, eRestoran.Model.Korisnik>();
        }
    }
}
