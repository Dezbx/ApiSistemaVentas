# 🧾 Sistema de Ventas e Inventario

Sistema de Ventas desarrollado en **.NET + SQL Server**, utilizando **Clean Architecture**, **Entity Framework Core**, auditoría completa y **Soft Delete**.  
El proyecto es **monolítico**, pero diseñado para escalar a microservicios si se requiere en el futuro.

---

## 📌 Objetivos del Proyecto

- Centralizar la gestión de:
  - Usuarios y roles
  - Clientes y empleados
  - Productos y categorías
  - Ventas
  - Inventario
- Garantizar:
  - Integridad de datos
  - Auditoría de cambios
  - Reglas de negocio encapsuladas en el dominio
- Mantener una arquitectura limpia, desacoplada y mantenible

---

## 🧱 Arquitectura General

El proyecto sigue **Clean Architecture**:

Ventas
│
├── Ventas.Domain
│ ├── Entities
│ │ ├── Common
│ │ │ └── AuditableEntity.cs
│ │ ├── Auditing
│ │ │ └── AuditLog.cs
│ │ ├── Security
│ │ │ ├── Rol.cs
│ │ │ └── Usuario.cs
│ │ └── ...
│ │
│ └── ValueObjects
│
├── Ventas.Application
│ ├── Interfaces
│ ├── Services
│ └── DTOs
│
├── Ventas.Infrastructure
│ ├── Persistence
│ │ ├── DbContext
│ │ └── Configurations
│ ├── Repositories
│ └── Migrations
│
└── Ventas.API
├── Controllers
└── Program.cs


---

## 🗄️ Base de Datos

- Motor: **SQL Server**
- Enfoque:
  - Esquemas por dominio (`seguridad`, `core`, `inventario`, `compartido`, `auditoria`)
  - Uso de **claves foráneas**
  - Uso de **Constantes** para estados
  - Auditoría completa

Ejemplo de tabla:

```sql
CREATE TABLE seguridad.Rol 
(
    RolId INT IDENTITY (1,1) PRIMARY KEY,
    Descripcion NVARCHAR(20) NOT NULL,

    CreatedAt DATETIME2(0) NOT NULL DEFAULT SYSUTCDATETIME(),
    CreatedBy INT NOT NULL,
    UpdatedAt DATETIME2(0) NULL,
    UpdatedBy INT NULL,
    IsDeleted BIT NOT NULL DEFAULT 0,

    CONSTRAINT UQ_Rol_Descripcion UNIQUE (Descripcion)
)
