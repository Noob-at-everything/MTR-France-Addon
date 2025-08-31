#!/bin/bash
# buildAll.sh - Compile pour toutes les versions

VERSIONS=("1.20.4" "1.20.1" "1.19.4")
ORIGINAL_VERSION=$(grep "minecraft_version=" gradle.properties | cut -d'=' -f2)

# Créer le dossier de sortie
mkdir -p build/releases

for VERSION in "${VERSIONS[@]}"; do
    echo "🔨 Building for Minecraft $VERSION..."

    # Modifier gradle.properties
    sed -i "s/minecraft_version=.*/minecraft_version=$VERSION/" gradle.properties

    # Clean et build
    ./gradlew clean build

    # Copier les JARs avec le bon nom
    cp build/MTRFranceAddon-fabric-*.jar "build/releases/MTRFranceAddon-fabric-${VERSION}.jar" 2>/dev/null
    cp build/MTRFranceAddon-forge-*.jar "build/releases/MTRFranceAddon-forge-${VERSION}.jar" 2>/dev/null

    echo "✅ Build for $VERSION complete!"
done

# Restaurer la version originale
sed -i "s/minecraft_version=.*/minecraft_version=$ORIGINAL_VERSION/" gradle.properties

echo "🎉 All builds complete! Check build/releases/"