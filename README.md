# PruebaIAInteractive

Descripción

La Video Game Catalog App es una aplicación que permite gestionar un catálogo de videojuegos de forma eficiente. La app permite a los usuarios realizar búsquedas, ver detalles de cada videojuego, editar y eliminar (de forma lógica) registros, todo utilizando una base de datos local.

Funcionalidades
Carga Inicial: La app descarga el catálogo completo de videojuegos desde la URL proporcionada: https://www.freetogame.com/api/games. Los datos se almacenan y manipulan a través de una base de datos local (CoreData).
Búsqueda y Filtros: Los usuarios pueden buscar videojuegos por nombre o por categoría, con sugerencias automáticas mientras escriben.
Detalle del Videojuego: Al seleccionar un videojuego, los usuarios pueden ver su título, miniatura y descripción breve. Además, pueden editar o eliminar el registro de forma lógica.
Requisitos

Xcode 15 o superior
iOS 15 o superior
Swift 5.0 o superior

Estructura de la App

La aplicación sigue un patrón MVVM (Model-View-ViewModel) para la arquitectura, con el objetivo de separar las responsabilidades y hacer que el código sea más limpio, mantenible y escalable.

Arquitectura General:
Model: Representa los datos de la aplicación. Aquí se define la estructura de los videojuegos, las categorías y sus relaciones.
View: Son las vistas (pantallas) que el usuario ve. Usamos SwiftUI para crear interfaces de usuario reactivas y dinámicas.
ViewModel: Contiene la lógica de negocio y se comunica con el Model. Se encarga de transformar los datos de la capa de modelo a un formato adecuado para la capa de vista.
Patrones de Diseño Utilizados:
MVVM (Model-View-ViewModel): Para mantener una separación clara entre la lógica de negocio y la presentación.
Repository Pattern: Usado para la gestión del acceso a la red (API) y la base de datos local.
Singleton: Para el manejo de la instancia única de la base de datos (CoreData).

Arquitectura de la Base de Datos

Se utiliza CoreData para persistir los datos de los videojuegos. Los datos se descargan desde la API y se almacenan localmente en la base de datos, lo que permite que los usuarios interactúen con ellos incluso sin conexión a Internet.

Modelos de CoreData:

VideoGame: Representa la entidad que almacena los datos de cada videojuego (título, descripción, categoría, etc.)
Category: Representa la categoría del videojuego.


Dependencias

Combine: Se utiliza para manejar la comunicación con la API y las actualizaciones de datos de forma reactiva.
CoreData: Para la persistencia local de los videojuegos.
SwiftUI: Para la creación de interfaces de usuario reactivas y dinámicas.
XCTest: Para las pruebas unitarias y de UI.


Descripción de Pantallas

Pantalla 1: Carga Inicial
Descripción: Se descarga el catálogo completo de videojuegos desde la URL https://www.freetogame.com/api/games.
Acción: Se realiza una petición GET utilizando Combine, y los resultados se almacenan en CoreData.
Persistencia: Los videojuegos se almacenan localmente y se sincronizan con la base de datos al ser descargados.
Búsqueda y Filtros
Descripción: Los usuarios pueden buscar videojuegos por nombre o categoría.
Acción: La búsqueda es realizada en tiempo real mientras el usuario escribe, con sugerencias automáticas de los resultados.
Persistencia: Los resultados de búsqueda se obtienen de la base de datos local.
Pantalla 2: Detalle del Videojuego
Descripción: Al hacer clic en un videojuego, se accede a la pantalla de detalles, donde se muestra la información básica como el título, miniatura y descripción breve.
Acción: Los usuarios pueden editar o eliminar el videojuego (eliminación lógica).
Persistencia: Los cambios se guardan en CoreData.
Funcionalidades y Reglas de Negocio

Carga de Datos desde la API
La aplicación utiliza Combine para manejar la comunicación con la API y obtener el catálogo completo de videojuegos.
Se utiliza un repositorio para centralizar las llamadas de red y la persistencia de datos.
Búsqueda y Filtros
Se realiza una búsqueda en vivo mientras el usuario escribe. Los resultados se filtran tanto por nombre como por categoría.
Los resultados de búsqueda se obtienen directamente desde la base de datos local, lo que asegura una experiencia más rápida y eficiente.
Edición y Eliminación de Videojuegos
Los usuarios pueden editar los detalles de un videojuego (título, descripción).

Testing

Se han implementado pruebas unitarias para verificar la funcionalidad de la aplicación. Estas pruebas se dividen en tres áreas principales:

Pruebas de Persistencia de Datos:
Se verifica que los datos se guarden y recuperen correctamente desde CoreData.
Pruebas de Networking:
Se utilizan mocks para simular las respuestas de la API y verificar que los datos sean procesados correctamente.
Pruebas de UI:
Se prueban las interacciones de la interfaz de usuario, como la búsqueda y la visualización de detalles, asegurando que la UI sea funcional y eficiente.
Implementación de Inyección de Dependencias

Para mejorar la testabilidad y la flexibilidad del proyecto, hemos utilizado inyección de dependencias a través de un contenedor de dependencias. Esto facilita la sustitución de componentes en las pruebas y permite que los servicios, como el repositorio de videojuegos, se inyecten en las vistas y ViewModels de manera eficiente.

Instrucciones de Instalación

Clona el repositorio:
git clone https://github.com/tu_usuario/VideoGameCatalogApp.git
Abre el proyecto en Xcode:
open VideoGameCatalogApp
Compila y ejecuta el proyecto en el simulador o un dispositivo físico.
Contribuciones

¡Las contribuciones son bienvenidas! Si encuentras algún bug o tienes una idea para mejorar la aplicación, siéntete libre de abrir un issue o un pull request.
