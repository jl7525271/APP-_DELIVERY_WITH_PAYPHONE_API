
# DELIVERY APP 

Proyecto desarrollado en flutter de una aplicacion tipo delivery con roles como: cliente, delivery, restaurant. La base de datos se construyo en Postgress y el backend en Node JS. 


## Acknowledgements

 - [Backend en Node JS](https://awesomeopensource.com/project/elangosundar/awesome-README-templates)
 - [Fire Base](https://console.firebase.google.com/u/2/project/flutter-rent-finder/storage/flutter-rent-finder.appspot.com/files?hl=es-419)
 - [Google Maps API](https://developers.google.com/maps/documentation/geocoding?hl=es-419)
 - [Sokect IO ](https://bulldogjob.com/news/449-how-to-write-a-good-readme-for-your-github-project)


## Badges

Add badges from somewhere like: [shields.io](https://shields.io/)

[![MIT License](https://img.shields.io/badge/License-MIT-green.svg)](https://choosealicense.com/licenses/mit/)
[![GPLv3 License](https://img.shields.io/badge/License-GPL%20v3-yellow.svg)](https://opensource.org/licenses/)
[![AGPL License](https://img.shields.io/badge/license-AGPL-blue.svg)](http://www.gnu.org/licenses/agpl-3.0)


## Demo

Insert gif or link to demo


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

