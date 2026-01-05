using Dapper;
using Microsoft.Extensions.DependencyInjection;
using Ventas.Domain.ValueObjects.Core;
using Ventas.Infraestructure.Persistence.Context;
using Ventas.Infraestructure.Persistence.TypeHandlers;

namespace Ventas.Infraestructure.DependencyInjection
{
    public static class DependencyInjection
    {
        public static IServiceCollection AddInfrastructure(this IServiceCollection services)
        {
            // Registro de la fábrica de conexiones
            services.AddSingleton<ISqlConnectionFactory, SqlConnectionFactory>();

            // Configuración global de TypeHandlers para Dapper
            SqlMapper.AddTypeHandler(new PrecioTypeHandler());
            // Agregar los demás Handlers aquí...

            // Registro de Repositorios (Ejemplo)
            // services.AddScoped<IProductoRepository, ProductoRepository>();
            // Registro de Handlers de Dapper
            SqlMapper.AddTypeHandler(new SkuTypeHandler());
            SqlMapper.AddTypeHandler(new PrecioTypeHandler());
            SqlMapper.AddTypeHandler(new CantidadTypeHandler());
            SqlMapper.AddTypeHandler(new CorreoElectronicoTypeHandler());
            SqlMapper.AddTypeHandler(new SexoTypeHandler());
            SqlMapper.AddTypeHandler(new TelefonoTypeHandler()); // Implementar igual que Correo
            SqlMapper.AddTypeHandler(new NombrePersonaTypeHandler());
            SqlMapper.AddTypeHandler(new NumeroDocumentoTypeHandler());
            SqlMapper.AddTypeHandler(new DireccionTypeHandler());
            SqlMapper.AddTypeHandler(new DescripcionTextoTypeHandler());
            SqlMapper.AddTypeHandler(new CodigoPeriodoTypeHandler());
            return services;
        }
    }
}
