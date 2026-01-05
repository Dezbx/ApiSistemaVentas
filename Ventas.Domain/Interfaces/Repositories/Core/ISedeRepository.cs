using Ventas.Domain.Entities.Core;
using Ventas.Domain.Interfaces.Repositories.Common;

namespace Ventas.Domain.Interfaces.Repositories.Core
{
    public interface ISedeRepository : IGenericRepository<Sede>
    {
        // 1. Validar si ya existe una sede en la misma dirección
        // Evita duplicados físicos en SQL Server
        Task<bool> ExisteSedeEnDireccionAsync(string direccion);

        // 2. Buscar sedes por una descripción parcial
        // Útil para filtros en la interfaz de usuario
        Task<IEnumerable<Sede>> ObtenerPorDescripcionAsync(string descripcion);

        // 3. Obtener sedes que tienen empleados asignados
        // Importante para la integridad referencial antes de un cierre
        Task<IEnumerable<Sede>> ObtenerSedesConEmpleadosAsync();

        // 4. Verificar si una sede es la "Principal" (si manejas ese concepto)
        // O si tiene movimientos de inventario asociados
        Task<bool> TieneMovimientosAsociadosAsync(int sedeId);
    }
}
