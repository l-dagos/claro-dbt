#!/bin/bash

# Script de comandos útiles para la demo de DBT - Phone Balance
# Ejecutar desde el directorio raíz del proyecto (donde está .env)

echo "🚀 Script de Demo DBT - Phone Balance"
echo "======================================"

# Asegurarnos de que DBT_PROFILES_DIR sea el directorio correcto
export DBT_PROFILES_DIR=$(pwd)/dbt
echo "DBT_PROFILES_DIR: $DBT_PROFILES_DIR"

# Cargar variables de entorno
set -o allexport
if [ -f ".env" ]; then
    source ".env"
    echo "✅ Variables de entorno cargadas desde .env"
else
    echo "⚠️  Archivo .env no encontrado. Asegúrate de tener las variables de entorno configuradas."
fi
set +o allexport

# Función para mostrar ayuda
show_help() {
    echo ""
    echo "Comandos disponibles:"
    echo "  setup     - Configurar entorno y validar conexión"
    echo "  run       - Ejecutar todos los modelos de phone_balance"
    echo "  test      - Ejecutar todos los tests"
    echo "  docs      - Generar y servir documentación"
    echo "  clean     - Limpiar archivos temporales"
    echo "  lineage   - Mostrar lineage de modelos"
    echo "  help      - Mostrar esta ayuda"
    echo ""
    echo "Nota: Ejecutar desde el directorio raíz del proyecto"
}

# Función para setup inicial
setup_demo() {
    echo "🔧 Configurando demo..."
    
    echo "Verificando conexión a base de datos..."
    ./run-dbt.sh debug
    
    echo "Instalando dependencias..."
    ./run-dbt.sh deps
    
    echo "✅ Setup completado"
}

# Función para ejecutar modelos
run_models() {
    echo "🏃 Ejecutando modelos de phone_balance..."
    
    echo "Ejecutando modelo base..."
    ./run-dbt.sh run --select base_phone_balance
    
    echo "Ejecutando modelos analíticos..."
    ./run-dbt.sh run --select balance_summary balance_segments segment_analysis balance_with_macro
    
    echo "✅ Modelos ejecutados exitosamente"
}

# Función para ejecutar tests
run_tests() {
    echo "🧪 Ejecutando tests de calidad..."
    
    ./run-dbt.sh test --select phone_balance
    
    echo "✅ Tests completados"
}

# Función para generar documentación
generate_docs() {
    echo "📚 Generando documentación..."
    
    ./run-dbt.sh docs generate
    echo "Sirviendo documentación en http://localhost:8080"
    echo "Presiona Ctrl+C para detener el servidor"
    ./run-dbt.sh docs serve
}

# Función para limpiar
clean_demo() {
    echo "🧹 Limpiando archivos temporales..."
    
    ./run-dbt.sh clean
    
    echo "✅ Limpieza completada"
}

# Función para mostrar lineage
show_lineage() {
    echo "🔗 Mostrando dependencias de modelos..."
    
    echo "Lineage de phone_balance:"
    ./run-dbt.sh ls --select phone_balance+ --output name
}

# Procesamiento de argumentos
case $1 in
    setup)
        setup_demo
        ;;
    run)
        run_models
        ;;
    test)
        run_tests
        ;;
    docs)
        generate_docs
        ;;
    clean)
        clean_demo
        ;;
    lineage)
        show_lineage
        ;;
    help)
        show_help
        ;;
    *)
        echo "❌ Comando no reconocido: $1"
        show_help
        exit 1
        ;;
esac 