using AutoMapper;
using eRestoran.Model.Requests;
using eRestoran.Model.SearchObjects;
using eRestoran.Services.Database;
using eRestoran.Services.NarudzbeStateMachine;
using Microsoft.EntityFrameworkCore;
using Microsoft.ML;
using Microsoft.ML.Data;
using Microsoft.VisualStudio.Services.Users;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.InteropServices;
using System.Text;
using System.Threading.Tasks;

namespace eRestoran.Services
{
    public class NarudzbaService:BaseCRUDService<Model.Narudzba,Narudzba,NarudzbaSearchObject,NarudzbaInsertRequest,NarudzbaUpdateRequest>, INarudzbaService
    {
        public BaseNarudzbaState _baseState { get; set; }
        public NarudzbaService(BaseNarudzbaState baseState,ERestoranContext context, IMapper mapper):base(context,mapper)
        {
            _context = context;
            _mapper = mapper;
            _baseState= baseState;
        }

        public override Task<Model.Narudzba> Insert(NarudzbaInsertRequest insert)
        {
            var state = _baseState.CreateState("initial");

            return state.Insert(insert);

        }

        public override async Task<Model.Narudzba> Update(int id, NarudzbaUpdateRequest update)
        {
            var entity = await _context.Narudzbas.FindAsync(id);

            var state = _baseState.CreateState(entity.StateMachine);

            return await state.Update(id, update);
        }

        public async Task<Model.Narudzba> Activate(int id)
        {
            var entity = await _context.Narudzbas.FindAsync(id);

            var state = _baseState.CreateState(entity.StateMachine);

            return await state.Activate(id);
        }

        public async Task<Model.Narudzba> Hide(int id)
        {
            var entity = await _context.Narudzbas.FindAsync(id);

            var state = _baseState.CreateState(entity.StateMachine);

            return await state.Hide(id);
        }

        public async Task<List<string>> AllowedActions(int id)
        {
            var entity = await _context.Narudzbas.FindAsync(id);
            var state = _baseState.CreateState(entity?.StateMachine ?? "initial");
            return await state.AllowedActions();
        }

        static MLContext mlContext = null;
        static object isLocked = new object();
        static ITransformer model = null;

        /*public List<Model.Narudzba> Recommend(int id)
        {
            lock (isLocked)
            {
                if (mlContext == null)
                {
                    mlContext = new MLContext();

                    var tmpData = _context.Narudzbas.Include("StavkeNarudzbes").ToList();

                    var data = new List<ProductEntry>();


                    foreach (var x in tmpData)
                    {
                        if (x.StavkeNarudzbes.Count > 1)
                        {
                            var distinctItemId = x.StavkeNarudzbes.Select(y => y.JeloId).ToList();

                            distinctItemId.ForEach(y =>
                            {
                                var relatedItems = x.StavkeNarudzbes.Where(z => z.JeloId != y);

                                foreach (var z in relatedItems)
                                {
                                    data.Add(new ProductEntry()
                                    {
                                        ProductID = (uint)y,
                                        CoPurchaseProductID = (uint)z.JeloId,
                                    });
                                }
                            });
                        }
                    }


                    var traindata = mlContext.Data.LoadFromEnumerable(data);

                    //STEP 3: Your data is already encoded so all you need to do is specify options for MatrxiFactorizationTrainer with a few extra hyperparameters
                    //        LossFunction, Alpa, Lambda and a few others like K and C as shown below and call the trainer.
                    MatrixFactorizationTrainer.Options options = new MatrixFactorizationTrainer.Options();
                    options.MatrixColumnIndexColumnName = nameof(ProductEntry.ProductID);
                    options.MatrixRowIndexColumnName = nameof(ProductEntry.CoPurchaseProductID);
                    options.LabelColumnName = "Label";
                    options.LossFunction = MatrixFactorizationTrainer.LossFunctionType.SquareLossOneClass;
                    options.Alpha = 0.01;
                    options.Lambda = 0.025;
                    // For better results use the following parameters
                    options.NumberOfIterations = 100;
                    options.C = 0.00001;

                    var est = mlContext.Recommendation().Trainers.MatrixFactorization(options);

                    model = est.Fit(traindata);

                }
            }




            //prediction

            var products = _context.Proizvodis.Where(x => x.ProizvodId != id);

            var predictionResult = new List<Tuple<Database.Proizvodi, float>>();

            foreach (var product in products)
            {

                var predictionengine = mlContext.Model.CreatePredictionEngine<ProductEntry, Copurchase_prediction>(model);
                var prediction = predictionengine.Predict(
                                         new ProductEntry()
                                         {
                                             ProductID = (uint)id,
                                             CoPurchaseProductID = (uint)product.ProizvodId
                                         });


                predictionResult.Add(new Tuple<Database.Proizvodi, float>(product, prediction.Score));
            }


            var finalResult = predictionResult.OrderByDescending(x => x.Item2).Select(x => x.Item1).Take(3).ToList();

            return _mapper.Map<List<Model.Proizvodi>>(finalResult);

        }*/

    }

    public class Copurchase_prediction
    {
        public float Score { get; set; }
    }

    public class ProductEntry
    {
        [KeyType(count: 10)]
        public uint ProductID { get; set; }

        [KeyType(count: 10)]
        public uint CoPurchaseProductID { get; set; }

        public float Label { get; set; }
    }
}