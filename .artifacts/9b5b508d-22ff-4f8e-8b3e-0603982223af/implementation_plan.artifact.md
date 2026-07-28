# Implementación de Pantalla de Detalles de Juego

Este plan detalla los pasos para permitir que el usuario vea información detallada de un juego al tocar su tarjeta en la lista.

## Cambios Propuestos

### Modelos y Datos

#### [MODIFY] [game_models.dart](file:///C:/proyect/proyectonitendo/lib/models/game_models.dart)
*   Añadir campos adicionales que vienen en la API (como fecha de lanzamiento y géneros) para enriquecer la pantalla de detalles.

### Componentes de UI

#### [MODIFY] [game_card.dart](file:///C:/proyect/proyectonitendo/lib/widgtes/game_card.dart)
*   Envolver el `Card` en un `GestureDetector` o `InkWell` para detectar el toque.
*   Añadir un callback `onTap` para que la navegación se maneje desde la pantalla principal.

### Nuevas Pantallas

#### [NEW] [game_detail_screen.dart](file:///C:/proyect/proyectonitendo/lib/screens/game_detail_screen.dart)
*   Crear una nueva pantalla que reciba el objeto `GameModel`.
*   Mostrar la imagen en grande, el título, la calificación, la fecha de lanzamiento y los géneros.

### Navegación

#### [MODIFY] [home_screen.dart](file:///C:/proyect/proyectonitendo/lib/screens/home_screen.dart)
*   Implementar la lógica de navegación al tocar una `GameCard`.

---

## Plan de Verificación

### Pruebas Manuales
*   Ejecutar la aplicación en el emulador.
*   Tocar cualquier tarjeta de juego en la lista principal.
*   Verificar que se abra la nueva pantalla con los datos correctos.
*   Tocar un juego desde los resultados de búsqueda y verificar que también navegue correctamente.
*   Usar el botón de retroceso para volver a la lista.
