using Dapper;
using System.Data;
using Ventas.Domain.ValueObjects.Shared;

namespace Ventas.Infraestructure.Persistence.TypeHandlers
{
    public class SexoTypeHandler : SqlMapper.TypeHandler<Sexo>
    {
        public override void SetValue(IDbDataParameter parameter, Sexo? value) => parameter.Value = value?.Valor;
        public override Sexo Parse(object value) => Sexo.Crear(Convert.ToChar(value));
    }
}
