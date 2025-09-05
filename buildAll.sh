#!/bin/bash
# buildAll.sh - Compile pour toutes les versions

# Arrête le script immédiatement si une commande échoue
set -e

VERSIONS=("1.20.4" "1.20.1" "1.19.4" "1.19.2" "1.18.2" "1.17.1" "1.16.5")
ORIGINAL_VERSION=$(grep "minecraft_version=" gradle.properties | cut -d'=' -f2)

# Créer le dossier de sortie HORS du dossier "build"
RELEASE_DIR="releases"
mkdir -p "$RELEASE_DIR"

echo "Running the 'setupFiles' configuration before doing anything..."
./gradlew setupFiles

echo "Cleaning workspace once before starting..."
./gradlew clean

for VERSION in "${VERSIONS[@]}"; do
    echo "--------------------------------------------------"
    echo "Building for Minecraft $VERSION..."
    echo "--------------------------------------------------"

    # -i.bak crée un backup, plus sûr et plus portable (macOS/Linux)
    sed -i.bak "s/minecraft_version=.*/minecraft_version=$VERSION/" gradle.properties

    # Build du projet
    ./gradlew build

    # Chercher les JARs principaux à copier
    FABRIC_JAR=$(find build -name "MTRFranceAddon-fabric-*.jar" ! -name "*-sources.jar" ! -name "*-javadoc.jar")
    FORGE_JAR=$(find build -name "MTRFranceAddon-forge-*.jar" ! -name "*-sources.jar" ! -name "*-javadoc.jar")

    # Copier les JARs s'ils existent
    if [ -f "$FABRIC_JAR" ]; then
        echo "Copying Fabric JAR..."
        cp "$FABRIC_JAR" "${RELEASE_DIR}/MTRFranceAddon-fabric-${VERSION}.jar"
    fi
    if [ -f "$FORGE_JAR" ]; then
        echo "Copying Forge JAR..."
        cp "$FORGE_JAR" "${RELEASE_DIR}/MTRFranceAddon-forge-${VERSION}.jar"
    fi

    echo "Build for $VERSION complete!"
done

# Restaurer la version originale et supprimer le backup
mv gradle.properties.bak gradle.properties

echo "=================================================="
echo "All builds complete! Check the '$RELEASE_DIR/' directory."
echo "=================================================="