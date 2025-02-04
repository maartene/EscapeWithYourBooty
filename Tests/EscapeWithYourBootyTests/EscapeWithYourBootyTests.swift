import Testing
@testable import EscapeWithYourBooty

@Suite("To make sure we get our bounty safely to shore") struct EscapeWithYourBootyTests {
    @Test("we should know that a sea without any navy is safe", arguments: [
        [
            ["X"]
        ],
        [
            ["X", "0"],
            ["0", "0"],
        ]
    ]) func aSeaWithoutAnyNavyIsSafe(sea: [[String]]) {
        #expect(isThisASafeRoute(in: .init(sea)) == true)
    }

    @Test("we can take a route where the navy won't be able to reach us", arguments: [
        [
            ["X"],
            ["0"],
            ["N"],
        ],
    ]) func aSeaWhereTheNavyCantReachUsIsSafe(sea: [[String]]) {
        #expect(isThisASafeRoute(in: .init(sea)) == true)
    }

    @Test("""
    we should not take this route, 
    because we have a navy ship directly in our surroundings
    """, arguments: [
        [
            ["X","N"]
        ],
        [
            ["X","0"],
            ["0","N"]
        ],
        [
            ["0", "N"],
            ["X", "0"]
        ],
        [
            ["N", "N"],
            ["X", "N"]
        ]
    ])
    func aSeaWhereTheNavyIsRightNextToUsTheRouteIsUnsafe(sea: [[String]]) {
        #expect(isThisASafeRoute(in: .init(sea)) == false)
    }

    @Test("""
    we should not take this route, 
    because we have a navy ship will cross our route
    """, arguments: [
        [
            ["X", "0", "N"]
        ],
        [
            ["X", "0", "0", "0", "N"]
        ],
        [
            ["X", "0", "N", "0", "0"]
        ],
        [
            ["X", "0", "N"],
            ["0", "0", "0"],
        ],
        [
            ["X", "0", "0", "0", "0"],
            ["0", "0", "0", "0", "N"],
        ],
        [
            ["X", "0", "0", "0", "0"],
            ["0", "0", "N", "0", "0"],
        ],
    ])
    func aSeaWhereTheNavyWillCrossOurRouteTheRouteIsUnsafe(sea: [[String]]) {
        #expect(isThisASafeRoute(in: .init(sea)) == false)
    }
}
