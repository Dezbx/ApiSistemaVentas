using Ventas.Domain.Entities.Shared;
using Ventas.Domain.Interfaces.Repositories.Common;

namespace Ventas.Domain.Interfaces.Repositories.Shared
{
    public interface IConstanteRepository : IGenericRepository<Constante>
    {   
        Task <IEnumerable<Constante>> ObtenerPorGrupoConstanteIdAsync(int grupoConstanteId);
        Task <bool> ExisteValorEnGrupoAsync(int grupoConstanteId, int valor);    
        Task  <bool> ExisteDescripcionEnGrupoAsync(int grupoConstanteId, string descripcion);
        Task <int> ContarConstantesEnGrupoAsync(int grupoConstanteId);
        Task <bool> TieneConstantesAsociadasAsync(int constanteId);     
        Task <Constante?> ObtenerConstantePorDescripcionAsync(int grupoConstanteId, string descripcion);    
    }
}
