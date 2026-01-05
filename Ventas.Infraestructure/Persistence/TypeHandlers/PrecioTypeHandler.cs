using Dapper;
using System.Data;
using Ventas.Domain.ValueObjects.Core;

namespace Ventas.Infraestructure.Persistence.TypeHandlers
{
    public class PrecioTypeHandler : SqlMapper.TypeHandler<Precio>
    {
        public override Precio? Parse(object value)
        {
            return Precio.Crear(Convert.ToDecimal(value));
        }

        public override void SetValue(IDbDataParameter parameter, Precio? value)
        {
            parameter.Value = value?.Valor;
        }
    }
}
