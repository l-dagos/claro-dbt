# Demo dbt para Claro - Phone Balance

Esta demostración utiliza únicamente la tabla `phone_balance` para mostrar las capacidades de dbt en el análisis de balances de líneas prepago.

## 🏗️ Arquitectura de Modelos

### Modelo Base
- **`base_phone_balance`**: Extrae y limpia datos de `ABT_MOTHER` para líneas prepago

### Modelos Analíticos
- **`balance_summary`**: Resumen estadístico con métricas agregadas
- **`balance_segments`**: Segmentación por rangos de balance  
- **`segment_analysis`**: Análisis de distribución por segmentos
- **`balance_with_macro`**: Demostración del uso de macros

## 📊 Qué podemos ver en esta demo?

### 1. Transformaciones básicas
- Renombramiento de columnas
- Filtros y condiciones WHERE

### 2. Lógicas de negocio
- Segmentación mediante CASE statements
- Cálculos de porcentajes
<!-- - (Se podría) clasificar clientes por tiers -->

### 3. Agregaciones
<!-- - Window functions para porcentajes -->
- Múltiples niveles de GROUP BY
- Funciones estadísticas (AVG, MEDIAN, etc.)

### 4. Referencias entre modelos
- Uso de `{{ ref() }}` para dependencias
<!-- - CTEs (Common Table Expressions) -->
<!-- - Cross joins para cálculos comparativos -->

## 🧪 Tests de calidad

Cada modelo incluye tests de datos para:
- **Integridad**: NOT NULL en campos críticos
- **Validación**: ACCEPTED_VALUES para categorías
- **Consistencia**: Validación de valores esperados

## 🚀 Correr la demo

```bash
# Usando el script helper
./demo-commands.sh setup    # Configurar entorno
./demo-commands.sh run      # Ejecutar modelos
./demo-commands.sh test     # Ejecutar tests  
./demo-commands.sh docs     # Generar documentación
./demo-commands.sh clean    # Limpiar temporales

# Usando run-dbt.sh directamente
./run-dbt.sh run --select phone_balance
./run-dbt.sh test --select phone_balance
./run-dbt.sh docs generate
./run-dbt.sh docs serve

# Ejecutar un modelo específico
./run-dbt.sh run --select base_phone_balance
```

## 📈 Métricas

### Summary del balance
- Total de líneas activas
- Balance promedio, mínimo, máximo
- Balance mediano y total agregado

### Análisis de segmentos 
- Distribución por rangos de balance
- Porcentaje de líneas por segmento
- Concentración de valor por segmento

### Balance usando macro
- Demo del uso de macros reutilizables
- Clasificación automática usando lógica centralizada
- Consistencia en la aplicación de reglas de negocio

## 🛠️ Macros

- **`balance_tier()`**: Macro reutilizable para clasificación de balances

## 📋 Estructura

```sql
-- phone_balance schema
created_at     DATE           -- Fecha del registro
phone_line     VARCHAR        -- Número de línea celular  
balance        NUMBER         -- Balance principal
last_update    DATE           -- Última actualización
```

Esta demo demuestra cómo dbt puede transformar una tabla de balances en un conjunto de métricas y análisis 