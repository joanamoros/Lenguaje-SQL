# Proyecto SQL – Consultas sobre base de datos de empleados

Este proyecto contiene un conjunto de **consultas SQL** realizadas sobre una base de datos relacional que modela la gestión de empleados, departamentos, trabajos y localizaciones de una empresa ficticia (basado en el esquema clásico *HR*).  

El objetivo es practicar y demostrar conocimientos de SQL: selección, filtrado, funciones de agregación, subconsultas, joins, agrupaciones y ordenaciones.  

---

## Modelo entidad – relación (E-R)

El modelo entidad–relación sobre el que se realizan las consultas está compuesto por las siguientes entidades y relaciones:

### **1. EMPLOYEES**
Tabla que contiene la información principal de los empleados.  
- **Clave principal (PK):** `EMPLOYEE_ID`  
- **Atributos:**  
  - `FIRST_NAME` (nombre)  
  - `LAST_NAME` (apellidos)  
  - `EMAIL` (correo electrónico)
  - `PHONE_NUMBER` (número de teléfono)
  - `HIRE_DATE` (fecha de contratación)  
  - `JOB_ID` (clave foránea a JOBS)  
  - `SALARY` (salario)  
  - `COMMISSION_PCT` (comisión)  
  - `MANAGER_ID` (clave foránea recursiva: jefe del empleado)  
  - `DEPARTMENT_ID` (clave foránea a DEPARTMENTS)  

### **2. DEPARTMENTS**
Tabla con los departamentos de la empresa.  
- **Clave principal (PK):** `DEPARTMENT_ID`  
- **Atributos:**  
  - `DEPARTMENT_NAME` (nombre del departamento)  
  - `MANAGER_ID` (clave foránea a EMPLOYEES: director del departamento)  
  - `LOCATION_ID` (clave foránea a LOCATIONS)  

### **3. JOBS**
Tabla con los tipos de trabajos y rangos salariales asociados.  
- **Clave principal (PK):** `JOB_ID`  
- **Atributos:**  
  - `JOB_TITLE` (nombre del puesto)  
  - `MIN_SALARY` (salario mínimo del puesto)  
  - `MAX_SALARY` (salario máximo del puesto)  

### **4. JOB_HISTORY**
Historial de los trabajos que han tenido los empleados en la empresa.  
- **Clave principal (PK) compuesta:** `EMPLOYEE_ID`, `START_DATE`  
- **Atributos:**  
  - `END_DATE` (fecha fin)  
  - `JOB_ID` (clave foránea a JOBS)  
  - `DEPARTMENT_ID` (clave foránea a DEPARTMENTS)  

### **5. LOCATIONS**
Ubicaciones físicas de los departamentos.  
- **Clave principal (PK):** `LOCATION_ID`  
- **Atributos:**  
  - `STREET_ADDRESS` (dirección)  
  - `POSTAL_CODE` (código postal)  
  - `CITY` (ciudad)  
  - `STATE_PROVINCE` (estado o provincia)  
  - `COUNTRY_ID` (clave foránea a COUNTRIES)  

### **6. COUNTRIES**
Países donde están situadas las localizaciones.  
- **Clave principal (PK):** `COUNTRY_ID`  
- **Atributos:**  
  - `COUNTRY_NAME`  
  - `REGION_ID` (clave foránea a REGIONS)  

### **7. REGIONS**
Regiones geográficas que agrupan países.  
- **Clave principal (PK):** `REGION_ID`  
- **Atributos:**  
  - `REGION_NAME`  

---

### Resumen de relaciones principales
- **EMPLOYEES** → `JOB_ID` → **JOBS**  
- **EMPLOYEES** → `DEPARTMENT_ID` → **DEPARTMENTS**  
- **EMPLOYEES** → `MANAGER_ID` → **EMPLOYEES** (autorreferencia: jerarquía de empleados)  
- **DEPARTMENTS** → `MANAGER_ID` → **EMPLOYEES**  
- **DEPARTMENTS** → `LOCATION_ID` → **LOCATIONS**  
- **LOCATIONS** → `COUNTRY_ID` → **COUNTRIES**  
- **COUNTRIES** → `REGION_ID` → **REGIONS**  
- **JOB_HISTORY** → `EMPLOYEE_ID` → **EMPLOYEES**  
- **JOB_HISTORY** → `JOB_ID` → **JOBS**  
- **JOB_HISTORY** → `DEPARTMENT_ID` → **DEPARTMENTS**  
