
# DELIVERY APP 

Proyecto desarrollado en flutter de una aplicacion tipo delivery con roles como: cliente, delivery, restaurant. La base de datos se construyo en Postgress y el backend en Node JS. 


## Implementations

 - [Backend en Node JS](https://awesomeopensource.com/project/elangosundar/awesome-README-templates)
 - [Fire Base](https://console.firebase.google.com/u/2/project/flutter-rent-finder/storage/flutter-rent-finder.appspot.com/files?hl=es-419)
 - [Google Maps API](https://developers.google.com/maps/documentation/geocoding?hl=es-419)
 - [Sokect IO ](https://socket.io/)


## Demo

[![loggin.png](https://i.postimg.cc/yxnYgb55/loggin.png)](https://postimg.cc/K3kyCJmr)
Interfaz de inicio de sesión de usuario

### Interfaz del cliente
[![products.png](https://i.postimg.cc/YCvq08xn/products.png)](https://postimg.cc/LJMM0twL) Productos ofrecidos por los restaurantes

[![products-descriptions.png](https://i.postimg.cc/63X9HKxg/products-descriptions.png)](https://postimg.cc/mcmfD0Dy)

[![order-client.png](https://i.postimg.cc/bNCwq41S/order-client.png)](https://postimg.cc/9r9hp88c)

[![restaurant-to-delivery.png](https://i.postimg.cc/kgLMb81n/restaurant-to-delivery.png)](https://postimg.cc/5XqMcHWG)

[![delivery-order.png](https://i.postimg.cc/mDYrRDST/delivery-order.png)](https://postimg.cc/7GL4nqcR)

[![payphone-link.png](https://i.postimg.cc/hGxDbj6V/payphone-link.png)](https://postimg.cc/cKxGdssJ)


[![payphonelink.png](https://i.postimg.cc/8kbC075H/payphonelink.png)](https://postimg.cc/xqcYkTLJ)




## Features

- Light/dark mode toggle
- Live previews
- Fullscreen mode
- Cross platform


## API Reference

#### Get all items

```http
  GET /api/items
```

| Parameter | Type     | Description                |
| :-------- | :------- | :------------------------- |
| `api_key` | `string` | **Required**. Your API key |

#### Get item

```http
  GET /api/items/${id}
```

| Parameter | Type     | Description                       |
| :-------- | :------- | :-------------------------------- |
| `id`      | `string` | **Required**. Id of item to fetch |

#### add(num1, num2)

Takes two numbers and returns the sum.


## Deployment

To deploy this project run

```bash
  npm run deploy
```



