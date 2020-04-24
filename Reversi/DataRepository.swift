//
//  DataRepository.swift
//  Reversi
//
//  Created by Kenji Tanaka on 2020/04/24.
//  Copyright © 2020 Yuta Koshizawa. All rights reserved.
//

import Foundation

class DataRepository {
    static var path: String {
        (NSSearchPathForDirectoriesInDomains(.libraryDirectory, .userDomainMask, true).first! as NSString).appendingPathComponent("Game")
    }

    func save(turn: Disk?, playerControls: [Player], board: [String]) throws {
        var output: String = ""
        output += turn.symbol
        playerControls.forEach {
            output += "\($0.rawValue)"
        }
        output += "\n"

        board.forEach {
            output += $0
            output += "\n"
        }

        do {
            try output.write(toFile: DataRepository.path, atomically: true, encoding: .utf8)
        } catch let error {
            throw FileIOError.read(path: DataRepository.path, cause: error)
        }
    }
}

enum FileIOError: Error {
    case write(path: String, cause: Error?)
    case read(path: String, cause: Error?)
}

extension Optional where Wrapped == Disk {
    public init?<S: StringProtocol>(symbol: S) {
        switch symbol {
        case "x":
            self = .some(.dark)
        case "o":
            self = .some(.light)
        case "-":
            self = .none
        default:
            return nil
        }
    }

    public var symbol: String {
        switch self {
        case .some(.dark):
            return "x"
        case .some(.light):
            return "o"
        case .none:
            return "-"
        }
    }
}

enum Player: Int {
    case manual = 0
    case computer = 1
}
