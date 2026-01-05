using Dapper;
using System.Data;
using Ventas.Domain.ValueObjects.Core;

namespace Ventas.Infraestructure.Persistence.TypeHandlers
{
    public class SkuTypeHandler : SqlMapper.TypeHandler<Sku>
    {
        public override void SetValue(IDbDataParameter parameter, Sku? value) => parameter.Value = value?.Valor;
        public override Sku Parse(object value) => Sku.Crear(value.ToString() ?? string.Empty);
    }
}
