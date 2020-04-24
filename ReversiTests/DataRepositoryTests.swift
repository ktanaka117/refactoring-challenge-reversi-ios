//
//  DataRepositoryTests.swift
//  ReversiTests
//
//  Created by Kenji Tanaka on 2020/04/24.
//  Copyright © 2020 Yuta Koshizawa. All rights reserved.
//

@testable import Reversi
import XCTest

class DataRepositoryTests: XCTestCase {

    private var path: String {
        (NSSearchPathForDirectoriesInDomains(.libraryDirectory, .userDomainMask, true).first! as NSString).appendingPathComponent("Game")
    }

    override func setUp() {
        super.setUp()

        try? FileManager.default.removeItem(at: URL(fileURLWithPath: path))
    }

    override func tearDown() {
        try? FileManager.default.removeItem(at: URL(fileURLWithPath: path))

        super.tearDown()
    }

    func test保存() {
        let repository = DataRepository()
        try! repository.save(
            turn: .dark,
            playerControls: [.manual, .manual],
            board:
            [
                "--------",
                "--------",
                "--------",
                "---ox---",
                "---xo---",
                "--------",
                "--------",
                "--------"
        ]
        )

        let savedData = try! String(contentsOfFile: path, encoding: .utf8)
        XCTAssertEqual(
            savedData,
            "x00\n--------\n--------\n--------\n---ox---\n---xo---\n--------\n--------\n--------\n")
    }

}
