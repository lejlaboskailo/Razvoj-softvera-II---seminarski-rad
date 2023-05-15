using Azure.Core;
using eRestoran.Helper;
using eRestoran.Model;
using eRestoran.Services;
using Microsoft.AspNetCore.Authentication;
using Microsoft.Extensions.Options;
using System.Net.Http.Headers;
using System.Security.Claims;
using System.Text;
using System.Text.Encodings.Web;

namespace eRestoran
{
    //public class BasicAuthenticationHandler : AuthenticationHandler<AuthenticationSchemeOptions>
    //{
    //    public IKorisniciService _korisniciService { get; set; }

    //    public BasicAuthenticationHandler(
    //    IKorisniciService korisniciService,

    //    IOptionsMonitor<AuthenticationSchemeOptions> options, ILoggerFactory logger, UrlEncoder encoder, ISystemClock clock)
    //        : base(options, logger, encoder, clock)
    //    {
    //        _korisniciService = korisniciService;
    //    }


    //    protected override async Task<AuthenticateResult> HandleAuthenticateAsync()
    //    {
    //        if (!Request.Headers.ContainsKey("Authorization"))
    //        {
    //            return AuthenticateResult.Fail("Missing authentication header! ");
    //        }
    //        var authHeader = AuthenticationHeaderValue.Parse(Request.Headers["Authorization"]);
    //        var credentialsBytes = Convert.FromBase64String(authHeader.Parameter);
    //        var credentials = Encoding.UTF8.GetString(credentialsBytes).Split(":");

    //        var username = credentials[0];
    //        var password = credentials[1];

    //        var user = _korisniciService.Login(username, password);


    //        if (user == null)
    //            return AuthenticateResult.Fail("Wrong Username or Password ! ");


    //        return AuthenticateResult.Fail("Invalid login ! ");


    //    }
    //}

    public class BasicAuthenticationHandler : AuthenticationHandler<AuthenticationSchemeOptions>
    {
        public IKorisniciService _korisniciService;
        public BasicAuthenticationHandler(IOptionsMonitor<AuthenticationSchemeOptions> options,
                                          ILoggerFactory logger,
                                          UrlEncoder encoder,
                                          ISystemClock clock,
                                          IKorisniciService korisniciService) : base(options, logger, encoder, clock)
        {
            _korisniciService = korisniciService;
        }

        protected override async Task<AuthenticateResult> HandleAuthenticateAsync()
        {
            if (!Request.Headers.ContainsKey("Authorization"))
            {
                return AuthenticateResult.Fail("Missing authorization header");
            }

            Korisnik user = null;

            try
            {
                var authHeader = AuthenticationHeaderValue.Parse(Request.Headers["Authorization"]);
                var credentialBytes = Convert.FromBase64String(authHeader.Parameter);
                var credentials = Encoding.UTF8.GetString(credentialBytes).Split(':');
                var username = credentials[0];
                var password = credentials[1];

                user = await _korisniciService.Login(username, password);

            }
            catch (Exception ex)
            {
                return AuthenticateResult.Fail("Incorrect username or password");
            }

            if (user == null)
                return AuthenticateResult.Fail("Invalid Username or Password");

            var claims = new List<Claim> {
                new Claim(ClaimTypes.NameIdentifier, user.Id.ToString()),
                new Claim(ClaimTypes.Name, user.Ime),
            };

            //foreach (var role in user.KorisniciUloges)
            //{
            //    claims.Add(new Claim(ClaimTypes.Role, role.Uloga.Naziv));
            //}

            //claims.Add(new Claim(ClaimTypes.Role, korisnik.TipKorisnika.Naziv));

            var identity = new ClaimsIdentity(claims, Scheme.Name);
            var principal = new ClaimsPrincipal(identity);
            var ticket = new AuthenticationTicket(principal, Scheme.Name);

            return AuthenticateResult.Success(ticket);
        }


    }
}
