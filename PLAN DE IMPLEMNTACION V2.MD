# 🌸 Plan de Implementación Maestro: "Divine Beauty"

**Arquitectura:** Flutter Multiplataforma + Firebase Fireconsole

**Estética:** Boutique Minimal (Palette: #FFB6C1, #FFF0F5, #FFFFFF)

---

## I. FASE DE PREPARACIÓN Y SETUP ROSA

En esta etapa configuramos el "lienzo" donde trabajaremos.

### 1.1. Herramientas y Dependencias Core

Configuraremos el archivo `pubspec.yaml` con las versiones más estables para evitar conflictos de nulidad:

* **Core:** `firebase_core`, `cloud_firestore`, `firebase_auth`.
* **State Management:** `provider` (Gestión reactiva).
* **UI/Design:** `google_fonts` (Para fuentes elegantes como *Montserrat* o *Playfair*).
* **Utilities:** `font_awesome_flutter` (Iconografía premium).

### 1.2. Design System: Divine Pink & White

Definiremos un `ThemeData` global en `lib/config/theme.dart`:

* **PrimaryColor:** `#FFB6C1` (Rosa Pastel).
* **ScaffoldBackgroundColor:** `#FFFFFF` (Blanco Puro).
* **AccentColor:** `#F8BBD0` (Rosa suave para estados de selección).
* **CardTheme:** Bordes redondeados de 20px y sombras suaves (blur 10).

---

## II. FASE DE MODELADO: LAS 16 ENTIDADES DART

Convertiremos cada tabla del esquema en clases robustas con soporte para JSON.

| Grupo | Entidades (Modelos Dart) | Función en Divine Beauty |
| --- | --- | --- |
| **Catálogo** | `Marca`, `Categoria`, `Producto`, `Variante` | Define el stock, tonos (hex) y marcas de lujo. |
| **Ventas** | `Pedido`, `DetallePedido`, `Cupon` | Lógica de cálculo de precios y descuentos. |
| **Usuarios** | `Cliente`, `Direccion`, `Resena` | Perfil del usuario, geolocalización y feedback. |
| **Transacción** | `Pago`, `Factura` | Registro de métodos (PayPal/Tarjeta/Oxxo) y RFC. |
| **Logística** | `Envio`, `Proveedor`, `OrdenCompra`, `DetalleOrden` | Control de guías, paquetería y resurtido. |

---

## III. FASE DE INFRAESTRUCTURA (FIRECONSOLE)

Configuración de la base de datos `BDtiendamaquillaje` sin analytics inicial para máxima velocidad de respuesta.

* **Colección `productos`:** Estructura anidada para optimizar lecturas.
* **Seguridad:** Reglas de escritura solo para usuarios autenticados.
* **Auth:** Configuración de Google Sign-In con el branding de la app (Logo rosa sobre blanco).

---

## IV. FASE DE UI/UX: NAVEGACIÓN Y PANTALLAS

Diseñaremos 5 pantallas clave con flujo fluido y transiciones suaves.

1. **Login Screen:** * Fondo blanco con degradados rosa en los bordes.
* Botones redondeados con el texto "Entrar al mundo de la belleza".


2. **Home Screen (Inicio):** * **Banners dinámicos:** Promociones de marcas destacadas.
* **Categorías en burbujas:** Iconos minimalistas en rosa.


3. **Novedades Screen:** * Grid de productos con "Quick Add" (Botón flotante rosa).
* Lógica de **Favoritos** guardada en el perfil del cliente.


4. **Carrito Screen:** * Resumen de compra estilo "Recibo boutique".
* Input elegante para el código de **CUPON**.


5. **Yo Screen (Perfil):** * Avatar circular con borde rosa.
* Acceso rápido a **Historial de Pedidos** y **Direcciones**.



---

## V. FASE DE LÓGICA DE PAGO (CHECKOUT MULTIPLATAFORMA)

Captura de datos crítica para la integridad del negocio:

* **PayPal:** Implementación de redirección segura para captura del ID de transacción.
* **Tarjeta:** Formulario con validación visual inmediata y máscara de seguridad.
* **Oxxo:** Generación de vista de "Ficha de Pago" con `num_guia` temporal hasta la validación del depósito.

---

## VI. ESTRUCTURA DE CARPETAS (JERARQUÍA PROFESIONAL)

Así se verá tu proyecto en VS Code:

```text
lib/
├── config/             # firebase_options y theme_rosa.dart
├── models/             # 16 Archivos (marca.dart, producto.dart, etc.)
├── services/           # auth_service y firestore_service
├── providers/          # cart_provider, user_provider, catalog_provider
├── widgets/            # custom_button.dart (Pink style), product_card.dart
└── screens/            # Las 5 pantallas principales + Checkout

```

---

###PROMPT 

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

