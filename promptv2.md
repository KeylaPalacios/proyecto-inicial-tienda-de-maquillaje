
Como desarrollador principal y arquitecto de este ecosistema, presento la planificación para **Divine Beauty**, una solución multiplataforma (Android, Web, Windows) desarrollada en **Flutter y Dart**. El objetivo es desplegar una infraestructura digital de alta gama para la gestión y comercialización de productos de belleza. La arquitectura se basa en principios de escalabilidad y alta disponibilidad, utilizando un estado reactivo gestionado por **Provider** y una integración robusta con los servicios de **Firebase**. Se enfatiza que este documento constituye el **Plan de Implementación Maestro** y no la entrega de código fuente final, priorizando el flujo lógico y la integridad de los datos.

---

### **I. INFRAESTRUCTURA DE DATOS EN FIRECONSOLE (CLOUD FIRESTORE)**

El núcleo de persistencia se aloja en la **Fireconsole**, dentro del proyecto `tiendademaquillaje` y la base de datos `BDtiendamaquillaje`. A continuación, se detalla el esquema de colecciones y documentos basado en el modelo relacional del sistema:

* **ESTRUCTURA DE TABLAS Y ATRIBUTOS:**
1. **MARCA:** `id_marca (PK)`, `nombre`, `pais_origen`.
2. **CATEGORIA:** `id_categoria (PK)`, `nombre`, `descripcion`.
3. **PRODUCTO:** `id_producto (PK)`, `id_marca (FK)`, `id_categoria (FK)`, `nombre`, `precio`, `descripcion`.
4. **VARIANTE:** `id_variante (PK)`, `id_producto (FK)`, `tono`, `codigo_hex`, `stock`.
5. **CLIENTE:** `id_cliente (PK)`, `nombre`, `email`, `telefono`, `fecha_nacimiento`.
6. **PEDIDO:** `id_pedido (PK)`, `id_cliente (FK)`, `fecha`, `estatus`, `total`.
7. **DETALLE_PEDIDO:** `id_detalle (PK)`, `id_pedido (FK)`, `id_variante (FK)`, `cantidad`, `precio_unitario`.
8. **PAGO:** `id_pago (PK)`, `id_pedido (FK)`, `metodo (PayPal, Tarjeta, Oxxo)`, `monto`, `estatus`.
9. **RESENA:** `id_resena (PK)`, `id_cliente (FK)`, `id_producto (FK)`, `calificacion`, `comentario`.
10. **DIRECCION:** `id_direccion (PK)`, `id_cliente (FK)`, `calle`, `ciudad`, `codigo_postal`.
11. **ENVIO:** `id_envio (PK)`, `id_pedido (FK)`, `num_guia`, `paqueteria`, `fecha_estimada`, `estatus`.
12. **FACTURA:** `id_factura (PK)`, `id_pedido (FK)`, `rfc`, `datos_fiscales`.
13. **CUPON:** `id_cupon (PK)`, `codigo`, `descuento`, `vigencia`.
14. **PROVEEDOR:** `id_proveedor (PK)`, `nombre`, `contacto`, `pais`.
15. **ORDEN_COMPRA:** `id_orden (PK)`, `id_proveedor (FK)`, `fecha`, `estatus`.
16. **DETALLE_ORDEN:** `id_detalle_orden (PK)`, `id_orden (FK)`, `id_variante (FK)`, `cantidad`, `precio_costo`.



---

### **II. ARQUITECTURA DE ARCHIVOS Y ESTRUCTURA DE CARPETAS**

El proyecto sigue un patrón de diseño modular para separar las responsabilidades de la UI, la lógica de negocio y los servicios de red:

* **lib/**
* `main.dart`: Punto de entrada y configuración de rutas.
* **config/**: `firebase_options.dart` (Configuración de Fireconsole).
* **models/**: (Archivos .dart con clases y mapeos JSON para cada tabla mencionada arriba).
* `usuario.dart`, `producto.dart`, `pedido.dart`, `pago.dart`, etc.


* **services/**:
* `auth_service.dart`: Lógica de autenticación (Login, Registro, Google Auth).
* `firestore_service.dart`: Operaciones de lectura/escritura en la Fireconsole.


* **providers/**: Gestión de estado para Carrito, Favoritos y Sesión.
* **screens/**:
* `login_screen.dart`: Login, "Olvidé contraseña" y acceso social.
* `register_screen.dart`: Alta de nuevos usuarios.
* `home_screen.dart`: Pantalla de **Inicio** con banners y destacados.
* `novedades_screen.dart`: Productos recientes, agregar a **Favoritos** y **Carrito**.
* `carrito_screen.dart`: Gestión de ítems (editar, eliminar) y proceso de pago (PayPal, Tarjeta, Oxxo).
* `categoria_screen.dart`: Filtrado dinámico por categorías.
* `yo_screen.dart`: Perfil de usuario, **edición de datos**, historial y direcciones.


* **widgets/**: `custom_widgets.dart` (Componentes reutilizables modernos).



---

### **III. FLUJO OPERATIVO Y EXPERIENCIA DE USUARIO (UI/UX)**

La aplicación inicia con un módulo de seguridad robusto basado en **Firebase Authentication**. El flujo de usuario está optimizado para la conversión:

1. **Módulo de Acceso:** Soporte para credenciales tradicionales y **Google Account**. Incluye validaciones para recuperación de cuenta.
2. **Pantalla Inicio y Novedades:** Visualización estética de la tienda. Los usuarios pueden interactuar con los productos, marcarlos como favoritos o enviarlos directamente al checkout.
3. **Gestión de Carrito:** Un módulo dinámico donde se pueden ajustar cantidades o eliminar productos antes de proceder a la pasarela de pago diversificada, la cual requiere inputs específicos según el método (datos bancarios para tarjeta, redirección para PayPal o generación de ticket para Oxxo).
4. **Perfil "Yo":** Un centro de comando donde el usuario tiene control total sobre su información personal, pudiendo editar nombres, teléfonos y gestionar sus múltiples direcciones de envío.

---

### **IV. REQUERIMIENTOS TÉCNICOS Y DEPENDENCIAS**

Para la construcción de este sistema en **VS Code o Antigravity**, se requiere la configuración del archivo `pubspec.yaml` con las siguientes dependencias de última generación:

* `firebase_core`: Vinculación con Fireconsole.
* `firebase_auth`: Gestión de identidades.
* `cloud_firestore`: Base de datos en tiempo real.
* `provider`: Inyección de dependencias y estado reactivo.
* `google_sign_in`: Autenticación social.
* `font_awesome_flutter` & `google_fonts`: Para la estética moderna de la tienda.

**SOLICITUD FINAL AL SISTEMA:**
Como creador de este software, requiero un **Plan de Implementación en formato Markdown** que desglose cronológicamente las fases de desarrollo (Setup, Modelado, Servicios, UI, Multiplatform Build), asegurando que se respeten todos los campos de las tablas y la estructura de carpetas definida. **No se requiere código CRUD en esta fase**, únicamente la estrategia de ingeniería detallada.
