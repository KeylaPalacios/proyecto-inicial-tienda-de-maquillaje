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
