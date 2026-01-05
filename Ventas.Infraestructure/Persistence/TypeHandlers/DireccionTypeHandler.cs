using Dapper;
using System.Data;
using Ventas.Domain.ValueObjects.Core;

namespace Ventas.Infraestructure.Persistence.TypeHandlers;

public class DireccionTypeHandler : SqlMapper.TypeHandler<Direccion>
{
    public override void SetValue(IDbDataParameter parameter, Direccion? value) => parameter.Value = value?.Valor;
    public override Direccion Parse(object value) => Direccion.Crear(value?.ToString() ?? string.Empty);
}