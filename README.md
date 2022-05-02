<p align="center">
  <a href="" rel="noopener">
 <img width=200px height=200px src="client/assets/launcher/icon.png" alt="Project logo"></a>
</p>

<h3 align="center">Courier Services</h3>

<div align="center">

[![Status](https://img.shields.io/badge/status-active-success.svg)]()
[![GitHub Issues](https://img.shields.io/github/issues/kylelobo/The-Documentation-Compendium.svg)](https://github.com/ojayjonathan/courier_services_mobile_apps/issues)
[![GitHub Pull Requests](https://img.shields.io/github/issues-pr/kylelobo/The-Documentation-Compendium.svg)](https://github.com/ojayjonathan/courier_services_mobile_apps/pulls)
[![License](https://img.shields.io/badge/license-MIT-blue.svg)](/LICENSE)

</div>

---

<p align="center">
Road cargo transport system mobile applications (driver, client)
</p>

## 📝 Table of Contents

- [About](#about)
- [Getting Started](#getting_started)
- [Usage](#usage)
- [Built Using](#built_using)

## 🧐 About <a name = "about"></a>

<p > 
Courier Services contain two mobile application that facilitate management and transportation of cargo by road.
    <br> 
</p>

<p > 
The application is aimed at linking transport service providers:

- trucks 🚛
- motobikes 🚲
- bicycles 🚲
- taxi 🚕
- and private car owners 🛻

with clients who wish to move goods from one location to another.
<br>

</p>
<p>
The project contain two applications:

- driver application
- client application

### Driver application

> Allow driver to:
>
> - create account and login
> - create and update their profile
> - receive and confirm shipament orders
> - create and update vehicle information
> - view shipment history

### Client application

> Allow client to:
>
> - create account and login
> - create and update their profile
> - create shipament orders
> - make shipment payment
> - view shipment history

</p>

## 🏁 Getting Started <a name ="getting_started"></a>

### Android

For each application;

#### Set up google maps api key

1. Open the the and the android folder
2. Locate the file `local.properties`; create if doesn't exist
3. Add your google maps api key as follows. Note DO NOT WRAP THE API KEY VALUE WITH QUOTE CHARACTERS
  > googleMapsApiKey=`YOUR_GOOGLE_MAPS_API_KEY_VALUE` 

4. In lib create a file conf.dart; `lib/conf.dart` and create a variable
```dart
const APIKey = "YOU_GOOGLE_MAPS_API_KEY";
```



## ⛏️ Built Using <a name = "built_using"></a>

- [Flutter](https://flutter.dev/docs)

## 🎈 Usage <a name="usage"></a>

### Installing Build apps

To install the android applications:

- Download the driver applications [driver](android_apk/driver.apk)
- Download the client applications [client](android_apk/client.apk)
