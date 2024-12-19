using AutoMapper;
using eRestoran;
using eRestoran.Model.SearchObjects;
using eRestoran.Services;
using eRestoran.Services.Database;
using eRestoran.Services.NarudzbeStateMachine;
using eRestoran.Services.Reports;
using Microsoft.AspNetCore.Authentication;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Internal;
using Microsoft.OpenApi.Models;
using Newtonsoft.Json.Serialization;
using System.Data.SqlClient;

var builder = WebApplication.CreateBuilder(args);

builder.Services.AddScoped<IDrzavaService, DrzavaService>();
builder.Services.AddScoped<IDojmoviService, DojmoviService>();
builder.Services.AddScoped<IGradService, GradService>();
builder.Services.AddScoped<IKorisniciService, KorisniciService>();
builder.Services.AddScoped<IUlogaService, UlogaService>();
builder.Services.AddScoped<IKategorijaService, KategorijaService>();
builder.Services.AddScoped<IJeloService, JeloService>();
builder.Services.AddScoped<INarudzbaService, NarudzbaService>();
builder.Services.AddScoped<IStatusNarudzbeService, StatusNarudzbeService>();
builder.Services.AddScoped<IStavkeNrudzbeService, StavkeNarudzbeService>();
builder.Services.AddScoped<IUplataService, UplataService>();
builder.Services.AddScoped<IReportService, ReportService>();



builder.Services.AddScoped<BaseNarudzbaState>();
builder.Services.AddScoped<InitialNarudzbaState>();
builder.Services.AddScoped<DraftNarudzbeState>();
builder.Services.AddScoped<ActiveNarudzbaState>();

builder.Services.AddControllers()
    .AddNewtonsoftJson(options =>
    {
        options.SerializerSettings.ContractResolver = new Newtonsoft.Json.Serialization.DefaultContractResolver();
    });
builder.Services.AddEndpointsApiExplorer();
// Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle

builder.Services.AddSwaggerGen(c =>
{
    c.AddSecurityDefinition("Basic", new OpenApiSecurityScheme()
    {
        Type = SecuritySchemeType.Http,
        Scheme = "basic"
    });

    c.AddSecurityRequirement(new OpenApiSecurityRequirement()
    {
        {
            new OpenApiSecurityScheme
            {
                Reference = new OpenApiReference 
                { 
                    Type = ReferenceType.SecurityScheme, 
                    Id = "Basic"
                }
            },
            new string[]{}
        }
    });
});


var connectionstring = builder.Configuration.GetConnectionString("DefaultConnection");
var context = builder.Services.AddDbContext<ERestoranContext>(options => options.UseSqlServer(connectionstring));
builder.Services.AddAutoMapper(typeof(IKorisniciService));
builder.Services.AddAuthentication("BasicAuthentication")
    .AddScheme<AuthenticationSchemeOptions, BasicAuthenticationHandler>("BasicAuthentication", null);

builder.Services.AddControllers().AddNewtonsoftJson(options =>
{
    options.SerializerSettings.ContractResolver = new DefaultContractResolver
    {
        NamingStrategy = new CamelCaseNamingStrategy()
    };
    options.SerializerSettings.ReferenceLoopHandling = Newtonsoft.Json.ReferenceLoopHandling.Ignore;
});
var app = builder.Build();

if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}

app.UseHttpsRedirection();
app.UseStaticFiles();

app.UseAuthentication();
app.UseAuthorization();

app.MapControllers();

app.Run();
