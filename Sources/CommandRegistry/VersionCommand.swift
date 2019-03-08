//
//  VersionCommand.swift
//  CommandRegistry
//
//  Created by Eneko Alonso on 3/7/19.
//

import Foundation
import Logger
import Utility

final class VersionCommand: Command {
    let command = "version"
    let overview = "Display the current version of this tool"

    let subparser: ArgumentParser
    var subcommands: [Command] = []

    init(parser: ArgumentParser) {
        subparser = parser
    }

    func run(with arguments: ArgumentParser.Result) throws {
//        Logger.standard.log(CommandRegistry.version)
        print("foo")
    }
}
