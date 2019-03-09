import CommandRegistry

var program = CommandRegistry(usage: "<subcommand> <options>", overview: "My awesome command line tool")
program.version = "1.0.0"
program.register(command: CommandA.self)
program.register(command: CommandB.self)
program.run()
