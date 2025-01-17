using System.ComponentModel.DataAnnotations;
using System.Diagnostics.CodeAnalysis;
using Microsoft.AspNetCore.Mvc;

namespace aspnet.Models;

public class Compania{
    public int IdCompania { get; set; }
    public string NombreCompania { get; set; }
}