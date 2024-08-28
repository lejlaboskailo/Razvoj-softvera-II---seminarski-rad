using eRestoran;
using eRestoran.Model.SearchObjects;
using eRestoran.Services;
using eRestoran.Services.Database;
using eRestoran.Services.OrderStateMachine;
using Microsoft.AspNetCore.Authentication;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Internal;
using Microsoft.OpenApi.Models;

var builder = WebApplication.CreateBuilder(args); 

// Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddAutoMapper(typeof(Program));
builder.Services.AddSwaggerGen(c =>
{
    c.AddSecurityDefinition("basicAuth", new Microsoft.OpenApi.Models.OpenApiSecurityScheme()
    {
        Type = Microsoft.OpenApi.Models.SecuritySchemeType.Http,
        Scheme = "basic"
    });
    c.AddSecurityRequirement(new Microsoft.OpenApi.Models.OpenApiSecurityRequirement
    {
           {
               new OpenApiSecurityScheme
               {
                   Reference = new OpenApiReference { Type = ReferenceType.SecurityScheme, Id = "basicAuth" }
               },
               new string[]{}
           }
    });
});

builder.Services.AddScoped<IDrzavaService, DrzavaService>();
builder.Services.AddScoped<IGradService, GradService>();
builder.Services.AddScoped<IKorisniciService, KorisniciService>();
builder.Services.AddScoped<IUlogeService, UlogeService>();
builder.Services.AddScoped<IKategorijaService, KategorijaService>();
builder.Services.AddScoped<IJeloService, JeloService>();
builder.Services.AddScoped<IDojmoviService,DojmoviService>();
builder.Services.AddScoped<INarudzbaService,NarudzbaService>();
builder.Services.AddScoped<IStatusNarudzbeService, StatusNarudzbeService>();
builder.Services.AddScoped<IStavkeNrudzbeService, StavkeNarudzbeService>();
builder.Services.AddScoped<IUplataService, UplataService>();

builder.Services.AddTransient<BaseState>();
builder.Services.AddTransient<AcceptedOrderState>();
builder.Services.AddTransient<CanceledOrderState>();
builder.Services.AddTransient<DeliveredOrderState>();
builder.Services.AddTransient<FinishedOrderState>();
builder.Services.AddTransient<InitialOrderState>();
builder.Services.AddTransient<InProgressOrderState>();

builder.Services.AddControllers();

builder.Services.AddAutoMapper(typeof(Program));


builder.Services.AddAuthentication("BasicAuthentication")

    .AddScheme<AuthenticationSchemeOptions, BasicAuthenticationHandler>("BasicAuthentication", null);

var connectionstring = builder.Configuration.GetConnectionString("DefaultConnection");
var context = builder.Services.AddDbContext<ERestoranContext>(options =>
            options.UseSqlServer(connectionstring));

var app = builder.Build();


// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}

app.UseHttpsRedirection();

app.UseAuthentication();

app.UseAuthorization();

app.MapControllers();

app.Run();
