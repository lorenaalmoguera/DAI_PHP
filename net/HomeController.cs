using System.Diagnostics;
using aspnet.Services;
using Microsoft.AspNetCore.Mvc;
using aspnet.Models;


namespace aspnet.Controllers;

public class HomeController : Controller
{
    private readonly ILogger<HomeController> _logger;
    private readonly IConfiguration configuration;
    private readonly IReservaRepository repositorioReservas;

    public HomeController(ILogger<HomeController> logger, IConfiguration configuration, IReservaRepository repositorioReservas)
    {
        _logger = logger;
        this.configuration = configuration;
        this.repositorioReservas = repositorioReservas;
    }

    public IActionResult Index()
    {
        return View();
    }

    public IActionResult Insertar(){
        return View();
    }

    public IActionResult Consulta(){
        return View();
    }

    [HttpPost]

    public async Task<IActionResult> listarCiudades(){
        IEnumerable<Ciudad> listarCiudades = await repositorioReservas.listarCiudades();
        return View("Consulta", listarCiudades);
    }

   [HttpPost]
   public async Task<IActionResult> insertarCompania(Compania compania){
    int id = await repositorioReservas.getIDCompania();
    compania.IdCompania = id;
    await repositorioReservas.insertarCompania(compania);
    ViewBag.msg = "Compania insertada con exito";
    return View("Insertar");
   } 

    [ResponseCache(Duration = 0, Location = ResponseCacheLocation.None, NoStore = true)]
    public IActionResult Error()
    {
        return View(new ErrorViewModel { RequestId = Activity.Current?.Id ?? HttpContext.TraceIdentifier });
    }

}
