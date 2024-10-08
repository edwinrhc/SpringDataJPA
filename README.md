# SpringAuditJPA

Este proyecto es una aplicación Java basada en Spring Boot que implementa auditoría de datos utilizando JPA (Java Persistence API) y Flyway para la gestión de migraciones de base de datos.

## Requisitos Previos

Antes de comenzar, asegúrate de tener instalados los siguientes requisitos:

- **Java 17**: El proyecto está configurado para usar Java 17.
- **Maven**: Este proyecto utiliza Maven como sistema de gestión de dependencias.
- **MySQL**: La base de datos MySQL es requerida para este proyecto.

## Instalación

1. Clona este repositorio:

   ```bash
   git clone https://tu-repo-url.git
   cd SpringAuditJPA

2. Configura base de datos MySQL
   ````bash
   CREATE DATABASE jpa_audit_db;

3. Configura las propiedades
   ````bash
   spring.datasource.url=jdbc:mysql://localhost:3306/spring_audit_jpa
   spring.datasource.username=tu-usuario
   spring.datasource.password=tu-contraseña
4. Crear los script en ```` db.migration  V#__name.sql````

### Explicación de las adiciones:

1. **Estructura de directorios y scripts Flyway**: Se incluyó una sección que describe cómo agregar los scripts de migración Flyway, con ejemplos específicos del proyecto.



