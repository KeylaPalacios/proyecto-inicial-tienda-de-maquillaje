
Actúa como un **Lead Software Architect**. El objetivo es la creación de un ecosistema digital multiplataforma denominado **"Divine Beauty"**, desarrollado bajo el SDK de **Flutter y el lenguaje Dart**. El sistema debe garantizar una experiencia nativa y fluida en **Android, iOS, Web y Windows**. La arquitectura se basa en una separación estricta de responsabilidades, utilizando **Provider** como motor de gestión de estado global para garantizar la reactividad de la interfaz y la sincronización de datos en tiempo real.

**II. INFRAESTRUCTURA BACKEND (FIRECONSOLE)**
La persistencia y lógica de servidor se centralizan en la **Fireconsole** de Firebase.

* **Configuración:** Se debe utilizar el estándar de configuración inicial (Modo Test/Estándar), **sin habilitar Google Analytics** ni configuraciones de producción avanzadas para simplificar el despliegue inicial.
* **Base de Datos:** Cloud Firestore bajo el identificador `BDtiendamaquillaje` con la colección principal `productos`.
* **Autenticación:** Firebase Auth integrado con Google Sign-In y flujos de recuperación de credenciales.

**III. MODELADO DE DATOS (ESQUEMA RELACIONAL EN FIRESTORE)**
El plan de implementación debe seguir estrictamente la estructura de entidades del diagrama relacional adjunto:

1. **MARCA:** `id_marca`, `nombre`, `pais_origen`.
2. **CATEGORIA:** `id_categoria`, `nombre`, `descripcion`.
3. **PRODUCTO:** `id_producto`, `id_marca`, `id_categoria`, `nombre`, `precio`, `descripcion`.
4. **VARIANTE:** `id_variante`, `id_producto`, `tono`, `codigo_hex`, `stock`.
5. **CLIENTE:** `id_cliente`, `nombre`, `email`, `telefono`, `fecha_nacimiento`.
6. **PEDIDO:** `id_pedido`, `id_cliente`, `fecha`, `estatus`, `total`.
7. **DETALLE_PEDIDO:** `id_detalle`, `id_pedido`, `id_variante`, `cantidad`, `precio_unitario`.
8. **PAGO:** `id_pago`, `id_pedido`, `metodo (PayPal, Tarjeta, Oxxo)`, `monto`, `estatus`.
9. **RESENA:** `id_resena`, `id_cliente`, `id_producto`, `calificacion`, `comentario`.
10. **DIRECCION:** `id_direccion`, `id_cliente`, `calle`, `ciudad`, `codigo_postal`.
11. **ENVIO:** `id_envio`, `id_pedido`, `num_guia`, `paqueteria`, `fecha_estimada`, `estatus`.
12. **FACTURA:** `id_factura`, `id_pedido`, `rfc`, `datos_fiscales`.
13. **CUPON:** `id_cupon`, `codigo`, `descuento`, `vigencia`.
14. **PROVEEDOR:** `id_proveedor`, `nombre`, `contacto`, `pais`.
15. **ORDEN_COMPRA:** `id_orden`, `id_proveedor`, `fecha`, `estatus`.
16. **DETALLE_ORDEN:** `id_detalle_orden`, `id_orden`, `id_variante`, `cantidad`, `precio_costo`.

**IV. ARQUITECTURA DE ARCHIVOS Y JERARQUÍA DE CARPETAS**
Se requiere una estructura profesional y escalable en la carpeta `lib/`:

* `main.dart`: Inicialización del App y de los MultiProviders.
* `config/`: `firebase_options.dart` y temas de diseño.
* `models/`: Definición de clases Dart para cada tabla mencionada.
* `services/`: `auth_service.dart` y `firestore_service.dart`.
* `providers/`: Lógica de estado para Carrito, Usuario y Catálogo (Uso de **ChangeNotifier**).
* `screens/`:
* `login_screen.dart`: Login, registro y recuperación.
* `home_screen.dart` (**Inicio**): Banners dinámicos y destacados.
* `novedades_screen.dart`: Productos recientes con lógica de **Favoritos** y adición rápida al carrito.
* `carrito_screen.dart`: Gestión de ítems (CRUD local), eliminación y checkout para **PayPal, Tarjeta y Oxxo**.
* `categoria_screen.dart`: Navegación por taxonomía de productos.
* `yo_screen.dart` (**Perfil**): Edición de datos personales, direcciones e historial.


* `widgets/`: `custom_widgets.dart` para componentes de UI tipo boutique.

**V. REQUERIMIENTO DE SALIDA**
Antes de proceder con la generación de código, genera un **Plan de Implementación en formato Markdown** que desglose:

1. **Fase de Preparación:** Herramientas en VS Code/Antigravity y dependencias en `pubspec.yaml` (core, auth, firestore, provider, google_sign_in).
2. **Fase de Modelado:** Estrategia para convertir las 16 tablas en modelos de Dart eficientes.
3. **Fase de UI/UX:** Lineamientos visuales modernos y flujo de navegación entre las 5 pantallas principales.
4. **Fase de Lógica de Pago:** Procedimiento para capturar datos específicos de PayPal, Tarjeta y Oxxo en el checkout.

**Nota:** *Como creador de software, exijo un procedimiento paso a paso que garantice un proyecto funcional, profesional y alineado con los estándares actuales de desarrollo multiplataforma.*
