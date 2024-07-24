# bank_app

A new Flutter project.

## Getting Started

Clone this repo to your local machine

### Prerequisites
You must have flutter sdk already set up on your machine. If not follow [this](https://docs.flutter.dev/get-started/install) instructions to set it up
use the latest stable version of flutter.

FVM is also recommended for managing flutter versions.

### Building
- For faster building the app has  `Melos - Melos is a tool that optimizes the workflow around managing multi-package repositories with git and Pub` enabled.  Check out its documentation [here](https://pub.dev/packages/melos). Common commands to use:
  ```dart
   melos bootstrap // Runs flutter pub get in all the modules
   melos clean // Cleans the current workspace and all its packages of temporary pub & generated Melos IDE files.
   melos run <scriptname>
  ```

Have included the scripts to get you quickly
Run [pub_get_build.zsh](pub_get_build.zsh)

- Open either android or iOS simulator. Both come with the flutter sdk.
- Check that an Android device is running. If none are shown, follow the device-specific instructions on the [Install](https://docs.flutter.dev/get-started/install) page for your OS.

  ```
   flutter devices
  ```

## Architecture
The app has been split into multiple modules ( main, core, features, shared and dependencies) in order to maintain explicit dependencies for each package with clear boundaries thet enforce the [single responsibility principle](https://en.wikipedia.org/wiki/Single-responsibility_principle). Modularizing our app in such a way brings benefits such as:

-   easy to reuse packages across multiple projects
-   CI/CD improvements in terms of efficiency (run checks on only the code that has changed)
-   easy to maintain the packages in isolation with their dedicated test suites, semantic versioning, and release cycle/cadence

### App structure
  ```
├── lib
├── modules
│   ├── core
│   ├── dependencies
│   └── features
└── test
```
### App layers
> Layering our code is incredibly important and helps us iterate quickly
> and with confidence. Each layer has a single responsibility and can be
> used and tested in isolation. This allows us to keep changes contained
> to a specific layer in order to minimize the impact on the entire
> application. In addition, layering our application allows us to easily
> reuse libraries across multiple projects (especially with respect to
> the data layer).

The app consists of 3 main layers:
- core layer
- dependencies layer
- features layer

#### Core layer
This layer is responsible for retrieving, storing and  sending data from  sources such as APIs and local data.
This layer does not depend on any UI and can be reused and even published on [pub.dev](https://pub.dev/) as a standalone package. It consists of blocs, repositories, models and local data storage helpers.
#### Dependencies layer
This layer is responsible for all the dependencies used in the app. It consists of `pubspec.yaml`  which holds all the dependencies another layer may need.
#### Features layer
This layer contains all of the application-specific features and use cases. Each feature generally consists of some UI and business logic. Blocs interact with zero or more repositories. Blocs react to events and emit states which trigger changes in the UI. Widgets within each feature should generally only depend on the corresponding bloc and render UI based on the current state. The UI can notify the bloc of user input via events.

#### Tests
![Business logic tests](Screenshot%202024-07-24%20at%204.20.39%E2%80%AFAM.png)

#### Coding standards
The app uses the following coding standards:



- [Flutter coding standars](https://github.com/flutter/flutter/wiki/Style-guide-for-Flutter-repo)
- [Dart style](https://dart.dev/guides/language/effective-dart/style)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,