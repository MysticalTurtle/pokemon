# Pokedex

This is a project to display a list of pokemons and its characteristics, also allows to seaach by entering the pokemon id or the name

You can sort by name or id.

The pokemon information comes from the api [PokemonApi](https://pokeapi.co/).

The project uses clean architecture with BLoC pattern, the dependency injection is defined in the injection_container.dart file.


## Installation

It's recommended to use the flutter version 3.16.2

To run the app, you have to take into account the next requisites and steps:

* You must have installed the Flutter version (3.16,2).
* Clone this repository.
* Create/use an Android/iOS emulator, or a physical device connected to the computer.
* If it is a physical device, you have to follow some extra steps:
	Android: https://www.geeksforgeeks.org/how-to-install-flutter-app-on-android/#:~:text=Using%20a%20USB%20cable%2C%20plug,recognizes%20your%20connected%20Android%20device.
	iOS: https://medium.com/front-end-weekly/how-to-test-your-flutter-ios-app-on-your-ios-device-75924bfd75a8
* Inside the folder of the repository, run "flutter clean", then "flutter pub get".
* Inside the folder of the repository, run "flutter run".


## Todo
- Add more animations
- Add an httpclient as a dependency injection in remote datasources

## Resources
The design was made from 
- [Figma](https://www.figma.com/file/jIIrEkkQifoCVKLtVoFkK1/Pok%C3%A9dex-(Community)?type=design&mode=design)
- [Apk](https://drive.google.com/file/d/1jAfSWW5W6EPIG_D1bymbfhbZP6MQg_do/view?usp=sharing)


