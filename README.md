# CommandRegistry 💻
Beautifully handle subcommands in your SwiftPM command line tool.

![Release](https://img.shields.io/github/release/eneko/CommandRegistry.svg)
![Swift 4.0+](https://img.shields.io/badge/Swift-4.0+-orange.svg)
[![Build Status](https://travis-ci.org/eneko/CommandRegistry.svg?branch=master)](https://travis-ci.org/eneko/CommandRegistry)
[![codecov](https://codecov.io/gh/eneko/CommandRegistry/branch/master/graph/badge.svg)](https://codecov.io/gh/eneko/CommandRegistry)
[![Swift Package Manager Compatible](https://img.shields.io/badge/spm-compatible-brightgreen.svg)](https://swift.org/package-manager)
![Linux Compatible](https://img.shields.io/badge/linux-compatible%20🐧-brightgreen.svg)


```
$ mytool
OVERVIEW: My awesome command line tool

USAGE: mytool <subcommand> <options>

SUBCOMMANDS:
  commandA     Does something awesome
  commandB     Does something awesome in a different way
```

## Usage 🛠
Keep your `main.swift` nice and tidy:

```swift
import CommandRegistry

var program = CommandRegistry(usage: "<subcommand> <options>", overview: "My awesome command line tool")
program.register(command: CommandA.self)
program.run()
```

### Define your subcommands as classes or structs ⌨️

```swift
import Utility
import CommandRegistry

class CommandA: Command {
    let command = "commandA"
    let overview = "Does something awesome"

    let subparser: ArgumentParser
    var subcommands: [Command] = []

    required init(parser: ArgumentParser) {
        subparser = parser.add(subparser: command, overview: overview)
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

### Easily define and process strongly-typed command arguments 😎

```swift
import CommandRegistry

var program = CommandRegistry(usage: "<subcommand> <options>", overview: "My awesome command line tool")
program.register(command: CommandA.self)
program.register(command: CommandB.self) // <-- New command
program.run()
```

```swift
import Utility
import CommandRegistry

class CommandB: Command {
    let command = "commandB"
    let overview = "Does something awesome in a different way"

    let subparser: ArgumentParser
    var subcommands: [Command] = []

    // Define an optional (non-required) integer argument
    private var numberArgument: OptionArgument<Int>

    required init(parser: ArgumentParser) {
        subparser = parser.add(subparser: command, overview: overview)
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

### Auto-generated `--help` 👌
By using `CommandRegistry` you get automatically generated help for your command line tool and all its subcommands

```
$ mytool --help
OVERVIEW: My awesome command line tool

USAGE: mytool <subcommand> <options>

SUBCOMMANDS:
  commandA     Does something awesome
  commandB     Does something awesome in a different way
```

```
$ mytool commandB --help
OVERVIEW: Does something awesome in a different way

OPTIONS:
  --number, -n   Number argument (optional)
```

### Auto-generated `--version` 🔢

```swift
import CommandRegistry

var program = CommandRegistry(usage: "<subcommand> <options>", overview: "My awesome command line tool")
program.version = "1.0.1"
program.register(command: CommandA.self)
program.register(command: CommandB.self)
program.run()
```

```
$ mytool --version
1.0.1
```


## Installation 🚀

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

## Why yet another argument and command parsing library? 🤔
When I started writing command line tools in Swift using Swift Package Manager, I found several packages that provided functionality to parse command line arguments, flags and subcommands. However, I found these libraries complex and hard to use.

Then I realized [Swift Package Manager](https://github.com/apple/swift-package-manager/tree/master/Sources) already provided this and many other common functionality that most command line tools normaly need. Thus, `CommandRegistry` is not "yet another argument and command parsing library", but a thin layer built on top of Swift Package Manager [`ArgumentParser`](https://github.com/apple/swift-package-manager/blob/master/Sources/Utility/ArgumentParser.swift) class.

I'd recommend you take a look at all the classes and types included with Swift Package Manager (the [`Utility`](https://github.com/apple/swift-package-manager/tree/master/Sources/Utility) module could be a good strting point), and start using those in your projects.
