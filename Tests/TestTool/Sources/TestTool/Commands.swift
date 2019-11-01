import SPMUtility
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

