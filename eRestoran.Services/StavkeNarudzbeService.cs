using AutoMapper;
using eRestoran.Model.Requests;
using eRestoran.Model.SearchObjects;
using eRestoran.Services.Database;
using Microsoft.AspNetCore.Mvc;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eRestoran.Services
{
    public class StavkeNarudzbeService : BaseCRUDService<Model.StavkeNarudzbe, Database.StavkeNarudzbe, StavkeNarudzbeSearchObject, StavkeNarudzbeUpsertRequest, StavkeNarudzbeUpsertRequest>, IStavkeNrudzbeService
    {
        private readonly ERestoranContext _context;
        private readonly IMapper _mapper;

        public StavkeNarudzbeService(ERestoranContext context, IMapper mapper) : base(context, mapper)
        {
            _context = context;
            _mapper = mapper;
        }

        [HttpPost]
        public async Task<List<Model.StavkeNarudzbe>> InsertAsync(List<StavkeNarudzbeUpsertRequest> request)
        {
            var entities = request.Select(i => _mapper.Map<StavkeNarudzbe>(i)).ToList();



            await _context.StavkeNarudzbes.AddRangeAsync(entities);
            await _context.SaveChangesAsync();



            var model = entities.Select(i => _mapper.Map<Model.StavkeNarudzbe>(i)).ToList();
            return model;
        }
    }
}
