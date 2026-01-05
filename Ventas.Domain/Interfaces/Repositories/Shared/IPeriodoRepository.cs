using Ventas.Domain.Entities.Shared;
using Ventas.Domain.Interfaces.Repositories.Common;

namespace Ventas.Domain.Interfaces.Repositories.Shared
{
    public interface IPeriodoRepository : IGenericRepository<Periodo>
    {
        Task<bool> GenerarPeriodosAnualesAsync(int anio, int usuarioId);
        // 1. Obtener el periodo actual marcado como activo
        // Fundamental para transacciones de ventas e inventario
        Task<Periodo?> ObtenerPeriodoActualAsync();

        // 2. Buscar por el código de periodo (ej: "202601")
        // Usa el Value Object CodigoPeriodo definido en tu arquitectura
        Task<Periodo?> ObtenerPorCodigoAsync(string codigo);

        // 3. Validar si un periodo ya existe antes de crearlo
        Task<bool> ExisteCodigoAsync(string codigo);

        // 4. Obtener periodos por rango de fechas
        Task<IEnumerable<Periodo>> ObtenerPorRangoFechasAsync(DateTime inicio, DateTime fin);

        // 5. Obtener periodos según su estado (Activo/Inactivo)
        // Relacionado con tus métodos Activar() y Desactivar()
        Task<IEnumerable<Periodo>> ObtenerPorEstadoAsync(bool estaActivo);
    }
}
