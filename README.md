# App de Geolocalización en Tiempo Real

Una aplicación móvil desarrollada con **Flutter** que permite capturar, visualizar y gestionar coordenadas geográficas en tiempo real. Este proyecto demuestra la integración de servicios de ubicación y mapas en entornos multiplataforma (Android/iOS).

## 🚀 Características
- **Ubicación GPS:** Obtención de coordenadas exactas (latitud y longitud) utilizando el sensor del dispositivo.
- **Mapas Interactivos:** Visualización de la posición actual sobre un mapa dinámico.
- **Permisos Dinámicos:** Gestión de permisos de ubicación para Android e iOS siguiendo las mejores prácticas.
- **Multiplataforma:** Soporte completo para dispositivos móviles y bases para web/escritorio.

## 🛠️ Stack Tecnológico
- **Lenguaje:** [Dart](https://dart.dev/)
- **Framework:** [Flutter](https://flutter.dev/)
- **Plugins clave:** - `geolocator`: Para acceder a los servicios de ubicación.
  - `Maps_flutter`: Para la integración de mapas de Google.

## ⚙️ Configuración Previa

Para que la geolocalización funcione correctamente, asegúrate de configurar las API Keys y los permisos:

### Android
Agrega los permisos en `android/app/src/main/AndroidManifest.xml`:
```xml
<uses-permission name="android.permission.ACCESS_FINE_LOCATION" />
<uses-permission name="android.permission.ACCESS_COARSE_LOCATION" />
