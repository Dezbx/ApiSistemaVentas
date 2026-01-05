using Ventas.Domain.Entities.Shared;
using Ventas.Domain.Interfaces.Repositories.Common;

namespace Ventas.Domain.Interfaces.Repositories.Shared
{
    public interface ITipoPagoRepository : IGenericRepository<TipoPago>
    {
        // 1. Obtener por descripción (Ej: "Efectivo", "Tarjeta de Crédito", "Transferencia")
        // Útil para la lógica de cierre de caja
        Task<TipoPago?> ObtenerPorDescripcionAsync(string descripcion);

        // 2. Validar duplicados antes de crear un nuevo método de pago
        Task<bool> ExisteDescripcionAsync(string descripcion);

        // 3. Verificar si el tipo de pago es "Efectivo"
        // Útil para disparar lógica de apertura de cajón monedero
        Task<bool> EsPagoEnEfectivoAsync(int tipoPagoId);
    }
}
