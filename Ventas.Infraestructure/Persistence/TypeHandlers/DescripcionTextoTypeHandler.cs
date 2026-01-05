using Dapper;
using System.Data;
using Ventas.Domain.ValueObjects.Common;

namespace Ventas.Infraestructure.Persistence.TypeHandlers;

public class DescripcionTextoTypeHandler : SqlMapper.TypeHandler<DescripcionTexto>
{
    public override void SetValue(IDbDataParameter parameter, DescripcionTexto? value) => parameter.Value = value?  .Valor;

    // Como DescripcionTexto requiere longitud en su factory, usamos un valor genérico o el valor real si fuera necesario
    public override DescripcionTexto Parse(object value) => DescripcionTexto.Crear(value?.ToString() ?? string.Empty, 200);
}