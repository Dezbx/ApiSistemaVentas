using Dapper;
using System.Data;
using Ventas.Domain.ValueObjects.Shared;

namespace Ventas.Infraestructure.Persistence.TypeHandlers;

public class NumeroDocumentoTypeHandler : SqlMapper.TypeHandler<NumeroDocumento>
{
    public override void SetValue(IDbDataParameter parameter, NumeroDocumento? value) => parameter.Value = value?.Valor;
    public override NumeroDocumento Parse(object value) => NumeroDocumento.Crear(value?.ToString() ?? string.Empty);
}