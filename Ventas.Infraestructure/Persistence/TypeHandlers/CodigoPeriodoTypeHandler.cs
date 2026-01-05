using Dapper;
using System.Data;
using Ventas.Domain.ValueObjects.Shared;

namespace Ventas.Infraestructure.Persistence.TypeHandlers;

public class CodigoPeriodoTypeHandler : SqlMapper.TypeHandler<CodigoPeriodo>
{
    public override void SetValue(IDbDataParameter parameter, CodigoPeriodo? value) => parameter.Value = value?.Valor;
    public override CodigoPeriodo Parse(object value) => CodigoPeriodo.Crear(value?.ToString() ?? string.Empty);
}