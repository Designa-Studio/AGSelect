namespace BlazorAGS.Models
{
    public class ServiceGroup
    {
        public long Id { get; set; }
        public string Name { get; set; } = string.Empty;
        public string Description { get; set; } = string.Empty;
        public decimal PriceCar { get; set; }
        public decimal PriceJeepeta { get; set; }
        public decimal PriceSuv { get; set; }
        public decimal PriceCamioneta { get; set; }
        public decimal PriceCamion { get; set; }
        public decimal PriceMinivan { get; set; }
        public decimal PriceCamionDosEjes { get; set; }
        public decimal PriceTrailer { get; set; }
        public string? Image { get; set; }
        public string Status { get; set; } = "active";
        public DateTime CreatedAt { get; set; }

        public List<AdditionalService> AdditionalServices { get; set; } = new();

        public decimal GetPriceForVehicleType(string tipoVehiculo)
        {
            return (tipoVehiculo?.ToLowerInvariant().Trim()) switch
            {
                "car" or "automóvil" or "automovil" => PriceCar,
                "jeepeta" => PriceJeepeta,
                "suv" => PriceSuv,
                "camioneta" => PriceCamioneta,
                "minivan" => PriceMinivan,
                "camion" or "camión" => PriceCamion,
                "camiondosejes" or "camión dos ejes" => PriceCamionDosEjes,
                "trailer" or "tráiler" => PriceTrailer,
                _ => PriceCar > 0 ? PriceCar : (PriceJeepeta > 0 ? PriceJeepeta : PriceSuv)
            };
        }
    }
}
