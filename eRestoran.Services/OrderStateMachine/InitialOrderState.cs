using AutoMapper;
using eRestoran.Model.Requests;
using eRestoran.Services.Database;
using Microsoft.Extensions.Logging;
using Microsoft.VisualStudio.Services.Users;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.InteropServices;
using System.Text;
using System.Threading.Tasks;

namespace eRestoran.Services.OrderStateMachine
{
    public class InitialOrderState : BaseState
    {
        protected ILogger<InitialOrderState> _logger;
        public InitialOrderState(ILogger<InitialOrderState> logger, IServiceProvider serviceProvider, IMapper mapper, ERestoranContext context) : base(serviceProvider, mapper, context)
        {
            _logger = logger;
        }
        public override async Task<Model.Narudzba> Insert(NarudzbaUpsertRequest request)
        {
            var set = _context.Set<Database.Narudzba>();

            var entity = _mapper.Map<Database.Narudzba>(request);

            entity.StateMachine = "Initial";
            set.Add(entity);

            await _context.SaveChangesAsync();

            return _mapper.Map<Model.Narudzba>(entity);
        }
        public override async Task<Model.Narudzba> Cancel(int id)
        {
            var entity = await _context.Narudzbas.FindAsync(id);
            if (entity == null)
            {
                throw new UserException($"Order {id} does not exist");
            }
            entity.StateMachine = "Canceled";
            await _context.SaveChangesAsync();

            return _mapper.Map<Model.Narudzba>(entity);
        }
        public override async Task<Model.Narudzba> Accept(int id)
        {
            var entity = await _context.Narudzbas.FindAsync(id);
            if (entity == null)
            {
                throw new UserException($"Order {id} does not exist");
            }
            _logger.LogInformation($"Order {id} is accepted.");

            entity.StateMachine = "Accepted";
            await _context.SaveChangesAsync();

            //var factory = new ConnectionFactory { HostName = "localhost" };
            //using var connection = factory.CreateConnection();
            //using var channel = connection.CreateModel();

            //channel.QueueDeclare(queue: "product_accepted",
            //                     durable: false,
            //                     exclusive: false,
            //                     autoDelete: false,
            //                     arguments: null);

            //const string message = "Hello World!";
            //var body = Encoding.UTF8.GetBytes(message);

            //channel.BasicPublish(exchange: string.Empty,
            //                     routingKey: "product_accepted",
            //                     basicProperties: null,
            //                     body: body);

            var mappedEntity = _mapper.Map<Model.Narudzba>(entity);

            var rmqhost = Environment.GetEnvironmentVariable("RABBITMQ_HOST");
            var rmquser = Environment.GetEnvironmentVariable("RABBITMQ_USER");
            var rmqpass = Environment.GetEnvironmentVariable("RABBITMQ_PASSWORD");
            var rmqport = Environment.GetEnvironmentVariable("RABBITMQ_PORT");

           // using var bus = RabbitHutch.CreateBus($"host={rmqhost};username={rmquser};password={rmqpass};port={rmqport}");

            //bus.PubSub.Publish(mappedEntity);

            return mappedEntity;
        }

        public override async Task<Model.Narudzba> Deliver(int id)
        {
            var entity = await _context.Narudzbas.FindAsync(id);
            if (entity == null)
            {
                throw new UserException($"Order {id} does not exist");
            }
            entity.StateMachine = "Delivered";
            await _context.SaveChangesAsync();

            return _mapper.Map<Model.Narudzba>(entity);
        }
        public override async Task<List<string>> AllowedActions()
        {
            var list = await base.AllowedActions();

            list.Add("Accept");
            list.Add("Cancel");
            list.Add("Deliver");

            return list;
        }
    }
}
