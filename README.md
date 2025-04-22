# DIInject

DIInject is a lightweight dependency injection library designed to simplify the management of dependencies in your applications. It provides a simple and intuitive API for defining and resolving dependencies, making your code more modular and testable.

## Features

- Easy to use and integrate
- Supports constructor and property injection
- Singleton and transient lifetimes
- Thread-safe resolution

## Installation

### Using Swift Package Manager (SPM)

To add DIInject to your project using Swift Package Manager, add the following dependency to your `Package.swift` file:

```swift
dependencies: [
    .package(url: "https://github.com/balitax/DIInject.git", from: "1.0.0")
]
```

Then, include `"DIInject"` as a dependency for your target:

```swift
targets: [
    .target(
        name: "YourTargetName",
        dependencies: ["DIInject"]
    )
]
```

## Usage

Here's a quick example of how to use DIInject in your project:

```javascript
import { Container } from 'diinject';

// Define a service
class Logger {
  log(message) {
    console.log(message);
  }
}

// Define a class with dependencies
class App {
  constructor(logger) {
    this.logger = logger;
  }

  run() {
    this.logger.log('App is running');
  }
}

// Create a container and register services
const container = new Container();
container.register('logger', Logger);
container.register('app', App, ['logger']);

// Resolve and use the app
const app = container.resolve('app');
app.run();
```

## Contributing

We welcome contributions to DIInject! If you have suggestions, bug reports, or pull requests, please feel free to submit them on our [GitHub repository](https://github.com/balitax/DIInject).

## License

DIInject is licensed under the MIT License. See the [LICENSE](LICENSE) file for more information.

## Contact

For any questions or feedback, please contact us at [agus.c@icloud.com](mailto:agus.c@icloud.com).