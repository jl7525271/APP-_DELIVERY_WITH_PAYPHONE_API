
# DELIVERY APP 

Proyecto desarrollado en flutter de una aplicacion tipo delivery con roles como: cliente, delivery, restaurant. La base de datos se construyo en Postgress y el backend en Node JS. 


## Implementations

 - [Backend en Node JS](https://awesomeopensource.com/project/elangosundar/awesome-README-templates)
 - [Fire Base](https://console.firebase.google.com/u/2/project/flutter-rent-finder/storage/flutter-rent-finder.appspot.com/files?hl=es-419)
 - [Google Maps API](https://developers.google.com/maps/documentation/geocoding?hl=es-419)
 - [Sokect IO ](https://socket.io/)


## Demo

[![loggin.png](https://i.postimg.cc/yxnYgb55/loggin.png)](https://postimg.cc/K3kyCJmr)
- Interfaz de inicio de sesión de usuario

### Interfaz del cliente
[![products.png](https://i.postimg.cc/YCvq08xn/products.png)](https://postimg.cc/LJMM0twL) 
- Productos ofrecidos por los restaurantes

[![products-descriptions.png](https://i.postimg.cc/63X9HKxg/products-descriptions.png)](https://postimg.cc/mcmfD0Dy)

[![order-client.png](https://i.postimg.cc/bNCwq41S/order-client.png)](https://postimg.cc/9r9hp88c)

### Interfaz del restaurant
[![restaurant-to-delivery.png](https://i.postimg.cc/kgLMb81n/restaurant-to-delivery.png)](https://postimg.cc/5XqMcHWG)
- Asigna un pedido pagado a un delivery para ser despachado 


### Interfaz del delivery
[![delivery-order.png](https://i.postimg.cc/mDYrRDST/delivery-order.png)](https://postimg.cc/7GL4nqcR)
- Acepta el envio e inicia la entrega 
.
### UTILZIACION DE LA API DE PAYPHONE PARA GENERAR EL LINK DE PAGO
[![payphone-link.png](https://i.postimg.cc/hGxDbj6V/payphone-link.png)](https://postimg.cc/cKxGdssJ)

[![payphonelink.png](https://i.postimg.cc/3RTtWS22/payphonelink.png)](https://postimg.cc/TytV4c7P)




## Features

- Iniciar sesion y registrarse 
- Carga de productos en la pantalla del cliente
- Pagos por medio de Payphone 
- Actualizacion en tiempo real de ubicacion del pedido 
- Seleccion de roles 


## API Implementations

#### Get link payphone


```http
 POST /  https://pay.payphonetodoesposible.com/api/Links
```

```http
 HEADERS token de tipo «Authorization» con contenido “Bearer TUTOKEN”.
```

| Parameter | Type     | Description                |
| :-------- | :------- | :------------------------- |
| `amout` | `int` | **Required**. |
| `amountWithoutTax` | `int` | **Required**. es obligatorio si no se cobran valores con Iva |
| `amountWithTax` | `int` | **Required**. es obligatorio si se cobran valores con Iva |
| `tax` | `int` | **Required**. es obligatorio si se cobran valores con Iva |
| `clientTransactionId` | `string` | **Required**. Your API key |

Documentation: 
[payphonelink](https://docs.payphone.app/doc/linksdepago/#generar-links-de-pago-mediante-api)




## Deployment

To deploy this project run

#### Node Js
```bash
 run node server: install all dependencies / npm install
```

```bash
 terminal: node server.js 
```


#### Postgress 

```bash
 run all sql to create all tables
```
```bash
 run file db.sql 
```

#### Flutter
```bash
 install dependencies pubspec yaml / flutter pub get
```

```bash
 run project
```
