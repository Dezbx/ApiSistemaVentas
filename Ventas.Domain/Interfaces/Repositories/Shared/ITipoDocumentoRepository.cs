using Ventas.Domain.Entities.Shared;
using Ventas.Domain.Interfaces.Repositories.Common;
using Ventas.Domain.ValueObjects.Common;

namespace Ventas.Domain.Interfaces.Repositories.Shared
{
    public interface ITipoDocumentoRepository : IGenericRepository<TipoDocumento>
    {
        Task<TipoDocumento?> ObtenerPorDescripcionAsync(DescripcionTexto descripcion);
        Task<bool> ExisteDescripcionAsync(DescripcionTexto descripcion);
    }
}
