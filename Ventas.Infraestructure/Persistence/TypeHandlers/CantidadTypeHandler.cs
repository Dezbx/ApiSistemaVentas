using Dapper;
using System.Data;
using Ventas.Domain.ValueObjects.Core;

namespace Ventas.Infraestructure.Persistence.TypeHandlers
{
    public class CantidadTypeHandler : SqlMapper.TypeHandler<Cantidad>
    {
        public override void SetValue(IDbDataParameter parameter, Cantidad? value) => parameter.Value = value?.Valor;
        public override Cantidad Parse(object value) => Cantidad.Crear(Convert.ToInt32(value));
    }
}
