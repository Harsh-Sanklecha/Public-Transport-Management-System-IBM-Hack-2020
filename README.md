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
