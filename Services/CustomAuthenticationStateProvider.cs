using System.Security.Claims;
using Microsoft.AspNetCore.Components.Authorization;
using Microsoft.AspNetCore.Components.Server.ProtectedBrowserStorage;
using BlazorAGS.Models;

namespace BlazorAGS.Services
{
    public class CustomAuthenticationStateProvider : AuthenticationStateProvider
    {
        private readonly ProtectedLocalStorage _protectedLocalStorage;
        private readonly AuthService _authService;
        private ClaimsPrincipal _anonymous = new ClaimsPrincipal(new ClaimsIdentity());

        public CustomAuthenticationStateProvider(ProtectedLocalStorage protectedLocalStorage, AuthService authService)
        {
            _protectedLocalStorage = protectedLocalStorage;
            _authService = authService;
        }

        public override async Task<AuthenticationState> GetAuthenticationStateAsync()
        {
            try
            {
                var tokenResult = await _protectedLocalStorage.GetAsync<string>("authToken");
                if (tokenResult.Success && !string.IsNullOrWhiteSpace(tokenResult.Value))
                {
                    var principal = _authService.ValidarJwtToken(tokenResult.Value);
                    if (principal.Identity != null && principal.Identity.IsAuthenticated)
                    {
                        return new AuthenticationState(principal);
                    }
                }
            }
            catch
            {
                // Prerendering / LocalStorage failure fallback
            }

            return new AuthenticationState(_anonymous);
        }

        public async Task MarkUserAsAuthenticated(string token)
        {
            await _protectedLocalStorage.SetAsync("authToken", token);
            var principal = _authService.ValidarJwtToken(token);
            NotifyAuthenticationStateChanged(Task.FromResult(new AuthenticationState(principal)));
        }

        public async Task MarkUserAsLoggedOut()
        {
            await _protectedLocalStorage.DeleteAsync("authToken");
            NotifyAuthenticationStateChanged(Task.FromResult(new AuthenticationState(_anonymous)));
        }
    }
}
