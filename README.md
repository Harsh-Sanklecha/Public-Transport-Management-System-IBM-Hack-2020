# Public Transport Management System

Public Transport Management System is a mobile application made using flutter (A cross platform framework).The main objective of this application is to build a platform for integrated monitoring and passenger information servives. 


## Introduction

This application can be used by signing up using your gmail account or phone number after which you have the access to choose the mode of transport. Further you can choose the timings and the seats. You can then proceed to payment after which the ticket will be issued
This application ensures you follow social distancing and notifies you if you ever get in contact with a COVID +ve patient.
This will avoid the direct contact with the ticket collector and the passenger which maintains the safety measures. Tickets issued cannot be reused every ride a new ticket has to be taken.

## Features

- Minimal and simple user interface
- Bus / Train (MMTS) / Metro Schedule
- Scan nearby app user using BluetoothLE Scanner
- Advertise to nearby app user using BluetoothLE GATT Server
- Easy ticket booking ux
- Instant ticket generator (QR encrypted)

![ibm](https://user-images.githubusercontent.com/44742284/85989742-93311f80-ba0e-11ea-80ac-b0ed1d4bd3b5.gif)

## Description
 
The main goal behind the implementation of this app was to create a platform to provide protection and to maintain the social distance between the passengers.

We managed to achive this goal by developing an application (Mobile application) where a user can book and reserve his/her seat prior to the journey and generating an E-Ticket, by this minimizing any contact with the ticket personels. We are trying to build a system where a user will be notified they don't maintain social distancing and if they ever get in contact with COVID-19 victim.

The application's front-end UI/UX is made using FLutter, the user can signup/signin using his/her phone number or gmail account which is authenticated using Firebase Auth Services. The loggin credentials of the user are stored in Firestore Database. The schedule of the transportation system is maintained in Firestore database. Every transaction of the user is stored for future reference. We have made use of TCL(Transaction Control Language) for maintaining of each transaction.

## Setup
### Requirements

- Flutter SDK
- Latest Android platform tools
- Latest Android SDK tools
- Android SDK 21 or newer
- Emulator/ Mobile device

### Getting Started

1. Setting up flutter

```sh
    flutter -v
  ```

 2. Checking for dependencies
 
  ```sh
    flutter doctor
  ```
  
3. Configuring pubspec.ymal

```sh
    pub.get
  ```

4. Running main.dart

```sh
    flutter run
  ```
  
## Technology Stack

- Flutter 1.12.13 (Dart)
- Firebase Auth
- Firestore (NoSQL Database)
- BluetoothLE Scanner
- BluetoothLE GATT Server
- TCL

## Future Scope

These are the things which we look forward to add in the future updates:

- Nearby API (to get suggestions based on the location of the user)
- GSM tracing (to help in more precice locations of users)

## Team / Collaborators
- [Aashray Raj Mathur](https://github.com/aashrayrajm)
- [Karthika Ponnada](https://github.com/karthika251199)
- [Diana Susan Francis](https://github.com/Diana-999)
- [Harsh V Sanklecha](https://github.com/Harsh-Sanklecha)
