
# Car Accident Mobile App

## Overview
The Car Accident Mobile App is a comprehensive solution developed for my bachelor's project. This Flutter-based application interfaces with a Raspberry Pi to monitor and evaluate vehicle dynamics to detect accidents. Upon detecting an accident, the app communicates with a server to dispatch emergency services and notify predefined emergency contacts.

## Features
- **Real-time Accident Detection**: Connects to a Raspberry Pi to read and analyze vehicle data in real-time.
- **Emergency Alerts**: Automatically sends data to a central server which then dispatches emergency services upon detecting an accident.
- **User Management**: Allows users to register, log in, and manage their profiles within the app.
- **Emergency Contacts**: Users can add and manage emergency contacts who are notified in the event of an accident.

## Technologies Used
- **Flutter**: Used for developing the cross-platform mobile application.
- **Raspberry Pi**: Serves as the hardware interface for collecting vehicle data.
- **Dart**: The programming language used with Flutter.

## Getting Started

### Prerequisites
- Flutter installed on your development machine ([Flutter installation guide](https://flutter.dev/docs/get-started/install)).
- Raspberry Pi set up with the necessary sensors and software.

### Installation

1. **Clone the Repository**
   ```bash
   git clone https://github.com/rutolphis/Car-Accident-detector.git
   cd car-accident-mobile-app
   ```

2. **Install Dependencies**
   Run the following command in the project directory:
   ```bash
   flutter pub get
   ```

3. **Run the App**
   Connect a device or use an emulator:
   ```bash
   flutter run
   ```

## Usage
After launching the app and logging in, the user interface allows you to view real-time data from the connected Raspberry Pi. In case of an accident, the app will perform its designated alert and notification functions automatically.

