using System.ComponentModel.DataAnnotations;
using System.Diagnostics.CodeAnalysis;
using Microsoft.AspNetCore.Mvc;

namespace aspnet.Models;

public class Ciudad{
    public int IDCIUDAD { get; set; }
    public string CIUDAD { get; set; }
    public double TASA_AEROPUERTO { get; set; }
}