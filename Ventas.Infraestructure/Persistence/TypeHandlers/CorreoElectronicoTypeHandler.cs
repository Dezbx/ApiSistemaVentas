using Dapper;
using System.Data;
using Ventas.Domain.ValueObjects.Shared;

namespace Ventas.Infraestructure.Persistence.TypeHandlers
{
    public class CorreoElectronicoTypeHandler : SqlMapper.TypeHandler<CorreoElectronico>
    {
        public override void SetValue(IDbDataParameter parameter, CorreoElectronico? value) => parameter.Value = value?.Valor;
        public override CorreoElectronico Parse(object value) => CorreoElectronico.Crear(value.ToString() ?? string.Empty);
    }
}
