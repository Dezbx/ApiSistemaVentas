namespace Ventas.Domain.Entities.Core
{
    public class DetalleProveedor
    {
        public int ProveedorId { get; private set; }
        public int CategoriaId { get; private set; }

        // Propiedades de navegación (opcionales para Dapper, útiles para el diseño)
        public virtual Proveedor Proveedor { get; private set; } = null!;
        public virtual Categoria Categoria { get; private set; } = null!;

        protected DetalleProveedor() { }

        public DetalleProveedor(int proveedorId, int categoriaId)
        {
            if (proveedorId <= 0) throw new ArgumentException("Proveedor inválido");
            if (categoriaId <= 0) throw new ArgumentException("Categoría inválida");

            ProveedorId = proveedorId;
            CategoriaId = categoriaId;
        }
    }
}
