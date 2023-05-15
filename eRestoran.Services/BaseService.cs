using AutoMapper;
using eRestoran.Model.SearchObjects;
using eRestoran.Services.Database;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eRestoran.Services
{
        public class BaseService<T, TDb, TSearch> : IService<T, TSearch> where T : class where TDb : class where TSearch : BaseSearchObject
        {
            public ERestoranContext _context { get; set; }
            public IMapper _mapper { get; set; }
            public BaseService(ERestoranContext context, IMapper mapper)
            {
                _context = context;
                _mapper = mapper;
            }
            public virtual IEnumerable<T> Get(TSearch search = null)
            {
                var dbentity = _context.Set<TDb>().AsQueryable();

                dbentity = AddFilter(dbentity, search);

                dbentity = AddInclude(dbentity, search);

                if (search?.Page.HasValue == true && search?.PageSize.HasValue == true)
                {
                    dbentity = dbentity.Take(search.PageSize.Value).Skip(search.Page.Value * search.PageSize.Value);
                }

                var list = dbentity.ToList();

                return _mapper.Map<IEnumerable<T>>(list);

            }

            public virtual IQueryable<TDb> AddInclude(IQueryable<TDb> query, TSearch search = null)
            {
                return query;
            }
            public virtual TDb AddIncludeforGetById(TDb query)
            {
                return query;
            }
            public virtual IQueryable<TDb> AddFilter(IQueryable<TDb> query, TSearch search = null)
            {
                return query;
            }

            public virtual T GetById(int id)
            {
                var dbentity = _context.Set<TDb>();
                var result = dbentity.Find(id);

                result = AddIncludeforGetById(result);

                return _mapper.Map<T>(result);
            }
        }
}
