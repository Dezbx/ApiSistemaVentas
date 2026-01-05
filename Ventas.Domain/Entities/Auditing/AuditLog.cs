namespace Ventas.Domain.Entities.Auditing
{
    public class AuditLog
    {
        public long AuditLogId { get; private set; }
        public string TableName { get; private set; } = null!;
        public string RecordId { get; private set; } = null!;
        public string Action { get; private set; } = null!; // INSERT, UPDATE, DELETE
        public string? OldValues { get; private set; }
        public string? NewValues { get; private set; }
        public DateTime ChangedAt { get; private set; }
        public int ChangedBy { get; private set; }
        public string? IpAddress { get; private set; }

        protected AuditLog() { } // EF Core

        public AuditLog(
            string tableName,
            string recordId,
            string action,
            string? oldValues,
            string? newValues,
            int changedBy,
            string? ipAddress)
        {
            if (string.IsNullOrWhiteSpace(tableName))
                throw new ArgumentException("TableName es obligatorio");

            if (action is not ("INSERT" or "UPDATE" or "DELETE"))
                throw new ArgumentException("Acción inválida");

            TableName = tableName;
            RecordId = recordId;
            Action = action;
            OldValues = oldValues;
            NewValues = newValues;
            ChangedAt = DateTime.UtcNow;
            ChangedBy = changedBy;
            IpAddress = ipAddress;
        }
    }

}
