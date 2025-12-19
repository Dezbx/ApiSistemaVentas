namespace Ventas.Domain.Entities.Common
{
    public abstract class AuditableEntity
    {
        public DateTime CreatedAt { get; private set; } = DateTime.UtcNow;
        public int CreatedBy { get; private set; }

        public DateTime? UpdatedAt { get; private set; }
        public int? UpdatedBy { get; private set; }

        public bool IsDeleted { get; private set; } = false;

        protected AuditableEntity() { } // EF Core

        protected void SetCreated(int userId)
        {
            CreatedAt = DateTime.UtcNow;
            CreatedBy = userId;
        }

        public void SetUpdated(int userId)
        {
            UpdatedAt = DateTime.UtcNow;
            UpdatedBy = userId;
        }

        public void SoftDelete(int userId)
        {
            IsDeleted = true;
            SetUpdated(userId);
        }
    }
}
