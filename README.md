# Sistema de Ventas – Arquitectura y Diseño

Este proyecto corresponde a un **Sistema de Ventas** desarrollado como un **monolito modular**, aplicando principios de **Clean Architecture**, **DDD ligero** y **buenas prácticas de diseño de software**.

El objetivo principal es construir una base sólida, mantenible y escalable, sin caer en sobreingeniería, pero dejando el sistema preparado para crecer o migrar a microservicios en el futuro si fuera necesario.

---

## 🧱 Tipo de Arquitectura

- **Monolito modular**
- **Clean Architecture**
- **Separación por capas**
- **Dominio independiente de frameworks**
- **Auditoría y Soft Delete centralizados**

No es microservicios.  
Todos los módulos (Ventas, Inventario, Seguridad, etc.) viven en una **misma solución**, pero **claramente desacoplados**.

---

## 🛠️ Tecnologías y Herramientas

- **Lenguaje:** C#
- **Framework:** .NET 8
- **ORM:** Entity Framework Core 8
- **Base de Datos:** SQL Server
- **Estilo de arquitectura:** Clean Architecture + DDD
- **Control de versiones:** Git
- **IDE recomendado:** Visual Studio 2022+

---

## 📁 Estructura de la Solución

```text
Ventas
│
├── Ventas.Domain
│   ├── Entities
│   │   ├── Common
│   │   │   └── AuditableEntity.cs
│   │   │
│   │   ├── Auditing
│   │   │   └── AuditLog.cs
│   │   │
│   │   ├── Security
│   │   │   ├── Rol.cs
│   │   │   └── Usuario.cs
│   │   │
│   │   └── ...
│   │
│   └── ValueObjects
│
├── Ventas.Application
│   ├── Interfaces
│   ├── Services
│   └── DTOs
│
├── Ventas.Infrastructure
│   ├── Persistence
│   │   ├── DbContext
│   │   └── Configurations
│   │
│   ├── Repositories
│   └── Migrations
│
└── Ventas.API
    ├── Controllers
    └── Program.cs

## 🧠 Descripción de Capas

### 🔹 Ventas.Domain

Contiene el **corazón del negocio**.

- Entidades del dominio  
- Reglas de negocio  
- Auditoría (`AuditableEntity`, `AuditLog`)  
- Value Objects  

**Características:**
- No depende de ninguna otra capa  
- No contiene EF Core ni SQL  
- No conoce la base de datos ni la API  

👉 Aquí se define **qué es válido y qué no** dentro del sistema.

---

### 🔹 Ventas.Application

Contiene los **casos de uso** del sistema.

- Servicios de aplicación  
- Interfaces de repositorios  
- DTOs  
- Orquestación del dominio  

**Características:**
- No sabe cómo se guardan los datos  
- Solo define **qué necesita hacer** el sistema  

👉 Coordina el dominio sin conocer detalles técnicos.

---

### 🔹 Ventas.Infrastructure

Encargada de la **persistencia y tecnología**.

- Entity Framework Core  
- SQL Server  
- Implementación de repositorios  
- Configuraciones de entidades  
- Migraciones  

👉 Implementa las interfaces definidas en `Ventas.Application`.

---

### 🔹 Ventas.API

Capa de **exposición** del sistema.

- Controladores  
- Endpoints REST  
- Middlewares  
- Configuración de la aplicación  

👉 Es el **punto de entrada** del sistema.

---

## 🗄️ Base de Datos

**Motor:** SQL Server  
**Diseño:** Normalizado  

### Características

- Claves primarias con `IDENTITY`  
- Soft delete (`IsDeleted`)  
- Auditoría completa  
- Catálogos compartidos mediante tabla `Constante`  
- Índices para performance  

---

## 🛠️ Stack Tecnológico

| Tecnología | Versión / Uso |
|----------|---------------|
| .NET | .NET 8 |
| ASP.NET Core | Web API |
| Entity Framework Core | ORM |
| SQL Server | 2019+ |
| Power BI | Dashboards |
| Excel | Exportaciones |
| Git | Control de versiones |
| GitHub | Repositorio y portafolio |

---

## 🧪 Buenas Prácticas Aplicadas

- Separación de responsabilidades  
- Dominio rico (no anémico)  
- Soft delete  
- Auditoría transversal  
- Validaciones en el dominio  

🚀 **Preparado para entrevistas técnicas**

---

## 📌 Estado del Proyecto

🟡 **En desarrollo**

Actualmente se está construyendo:

- Modelo de dominio  
- Persistencia con EF Core  
- Estructura base de la API  

---

## 👤 Autor

Proyecto desarrollado como parte de un **portafolio profesional .NET Backend / BI**.
