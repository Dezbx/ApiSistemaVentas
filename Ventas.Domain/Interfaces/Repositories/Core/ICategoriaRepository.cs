using Ventas.Domain.Entities.Core;
using Ventas.Domain.Interfaces.Repositories.Common;
using Ventas.Domain.ValueObjects.Common;

namespace Ventas.Domain.Interfaces.Repositories.Core
{
    public interface ICategoriaRepository : IGenericRepository<Categoria>
    {
        // 1. Validar si ya existe una categoría con el mismo nombre para evitar el error de UNIQUE del SQL
        Task<bool> ExisteNombreAsync(DescripcionTexto nombre);
        Task<IEnumerable<Categoria>> ObtenerCategoriasConProductosAsync();
    }
}
