# CommandRegistry
Beautifully handle subcommands in your SwiftPM command line tool.

```
$ mytool
OVERVIEW: My awesome command line tool

USAGE: mytool <subcommand> <options>

SUBCOMMANDS:
  commandA     Does something awesome
  commandB     Does something awesome in a different way
```

## Usage
In your `main.swift`

```swift
import CommandRegistry

var commands = CommandRegistry(usage: "<subcommand> <options>", overview: "My awesome command line tool")
commands.register(command: CommandA.self)
commands.register(command: CommandB.self)
commands.run()
```

### Define your subcommands as classes or structs

```swift
import Utility
import CommandRegistry

class CommandA: Command {
    let command = "commandA"
    let overview = "Does something awesome"

    required init(parser: ArgumentParser) {
        _ = parser.add(subparser: command, overview: overview)
    }

    func run(with arguments: ArgumentParser.Result) throws {
        print("This is CommandA")
    }
}
```

```
$ mytool commandA
This is CommandA
```

### Easily define and process strongly-typed command arguments

```swift
import Utility
import CommandRegistry

class CommandB: Command {
    let command = "commandB"
    let overview = "Does something awesome in a different way"

    // Define an optional (non-required) integer argument
    private var numberArgument: OptionArgument<Int>

    required init(parser: ArgumentParser) {
        let subparser = parser.add(subparser: command, overview: overview)
        numberArgument = subparser.add(option: "--number", shortName: "-n", kind: Int.self, usage: "Number argument (optional)")
    }

    func run(with arguments: ArgumentParser.Result) throws {
        print("This is CommandB")
        if let number = arguments.get(numberArgument) {
            print("The number entered is \(number), it's square is \(number * number).")
        }
        else {
            print("You didn't enter any number. That is ok too.")
        }
    }
}
```

```
$ mytool commandB -n 10
This is commandB
The number entered is 10, it's square is 100.
```

## Installation

1. Add both CommandRegstry and SwiftPM depedencies to your `Package.swift`:
```swift
dependencies([
    .package(url: "https://github.com/eneko/CommandRegistry.git", from: "0.0.1"),
    .package(url: "https://github.com/apple/swift-package-manager.git", from: "0.1.0"),
]),
```

2. Update your target dependencies in `Package.swift`:
```swift
.target(name: "mytool", dependencies: ["CommandRegistry", "Utility"]),
```

3. Add `import CommandRegistry` and `import Utility` in your source files, as needed.

## Why yet another argument and command parsing library?
When I started writing command line tools in Swift using Swift Package Manager, I found several packages that provided functionality to parse command line arguments, flags and subcommands. However, I found these libraries complex and hard to use.

Then I realized Swift Package Manager already provided this and many other common functionality that most command line tools normaly need. Thus, `CommandRegistry` is not "yet another argument and command parsing library", but a thin layer built on top of Swift Package Manager `ArgumentParser` class.

I'd recommend you take a look at all the classes and types included with Swift Package Manager (the `Utility` module could be a good strting point), and start using those in your projects.
