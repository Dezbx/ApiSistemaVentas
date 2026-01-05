using Dapper;
using System.Data;
using Ventas.Domain.ValueObjects.Core;

namespace Ventas.Infraestructure.Persistence.TypeHandlers
{
    public class TelefonoTypeHandler : SqlMapper.TypeHandler<Telefono>
    {
        public override void SetValue(IDbDataParameter parameter, Telefono? value) => parameter.Value = value?.Valor;
        public override Telefono Parse(object value) => Telefono.Crear(value?.ToString() ?? string.Empty);
    }
}
