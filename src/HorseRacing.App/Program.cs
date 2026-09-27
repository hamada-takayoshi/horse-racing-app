using HorseRacing.App.Components;
using HorseRacing.App.Application.Races;
using HorseRacing.App.Data;
using HorseRacing.App.Data.Races;

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.
builder.Services.AddRazorComponents()
    .AddInteractiveServerComponents();
builder.Services.AddSingleton<SqlConnectionFactory>();
builder.Services.AddScoped<IRaceRepository, RaceRepository>();
builder.Services.AddScoped<RaceService>();

var app = builder.Build();

// Configure the HTTP request pipeline.
if (!app.Environment.IsDevelopment())
{
    app.UseExceptionHandler("/Error", createScopeForErrors: true);
}
app.UseStatusCodePagesWithReExecute("/not-found", createScopeForStatusCodePages: true);
app.UseAntiforgery();

app.MapStaticAssets();
app.MapRazorComponents<App>()
    .AddInteractiveServerRenderMode();

app.Run();
