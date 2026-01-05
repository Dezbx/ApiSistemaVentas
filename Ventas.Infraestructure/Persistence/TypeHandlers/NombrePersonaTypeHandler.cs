using Dapper;
using System.Data;
using Ventas.Domain.ValueObjects.Shared;

namespace Ventas.Infraestructure.Persistence.TypeHandlers
{
    public class NombrePersonaTypeHandler : SqlMapper.TypeHandler<NombrePersona>
    {
        public override void SetValue(IDbDataParameter parameter, NombrePersona? value) => parameter.Value = value?.Valor;
        public override NombrePersona Parse(object value) => NombrePersona.Crear(value?.ToString() ?? string.Empty);
    }
}
