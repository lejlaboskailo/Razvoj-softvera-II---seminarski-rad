using eRestoran;
using eRestoran.Services;
using eRestoran.Services.Database;
using Microsoft.AspNetCore.Authentication;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Internal;
using Microsoft.OpenApi.Models;

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.
builder.Services.AddAuthentication("BasicAuthentication")
    .AddScheme<AuthenticationSchemeOptions, BasicAuthenticationHandler>("BasicAuthentication", null);


// Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddAutoMapper(typeof(Program));
builder.Services.AddSwaggerGen(c =>
{
    c.AddSecurityDefinition("basicAuth", new OpenApiSecurityScheme
    {
        Type = SecuritySchemeType.Http,
        Scheme = "basic"
    });
    c.AddSecurityRequirement(new OpenApiSecurityRequirement
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

builder.Services.AddControllers();




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
