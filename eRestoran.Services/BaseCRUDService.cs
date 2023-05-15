using AutoMapper;
using eRestoran.Model.SearchObjects;
using eRestoran.Services.Database;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eRestoran.Services
{
    public class BaseCRUDService<T, TDb, TSearch, TInsert, TUpdate> : BaseService<T, TDb, TSearch>, ICRUDService<T, TSearch, TInsert, TUpdate>
                                   where T : class where TDb : class where TSearch : BaseSearchObject where TInsert : class where TUpdate : class
    {
        public BaseCRUDService(ERestoranContext context, IMapper mapper) : base(context, mapper)
        {
        }

        public virtual T Insert(TInsert insert)
        {
            var set = _context.Set<TDb>();

            TDb dbentity = _mapper.Map<TDb>(insert);

            set.Add(dbentity);
            BeforeInsert(insert, dbentity);
            _context.SaveChanges();

            return _mapper.Map<T>(dbentity);

        }

        //BeforeInsert is for some specific operations we need to do before inserting into the database
        public virtual void BeforeInsert(TInsert insert, TDb dbentity)
        {

        }
        //BeforeUpdate is for some specific operations we need to do before updating the database
        public virtual void BeforeUpdate(TUpdate update, TDb dbentity)
        {

        }

        public virtual T Update(int id, TUpdate update)
        {
            var set = _context.Set<TDb>();

            var dbentity = set.Find(id);

            if (dbentity != null)
            {
                _mapper.Map(update, dbentity);
            }
            else
                return null;
            BeforeUpdate(update, dbentity);

            _context.SaveChanges();

            return _mapper.Map<T>(dbentity);

        }

        //BeforeDelete is for some specific operations we need to do before deleting the object from databse
        public virtual void BeforeDelete(TDb dbentity)
        {

        }
        public virtual void AfterDelete(TDb dbentity)
        {

        }
        public virtual T Delete(int id)
        {
            var set = _context.Set<TDb>();

            var dbentity = set.Find(id);

            if (dbentity == null)
            {
                return null;
            }

            var deletedEntity = dbentity;

            BeforeDelete(deletedEntity);

            set.Remove(dbentity);
            AfterDelete(deletedEntity);

            _context.SaveChanges();

            return _mapper.Map<T>(deletedEntity);
        }
    }
}
