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
    ]) func aSeaWithoutAnyNavyIsSafe(sea: [[Character]]) {
        #expect(isThisASafeRoute(in: sea) == true)
    }

    @Test("we can take a route where the navy won't be able to reach us", arguments: [
        [
            ["X"],
            ["0"],
            ["N"],
        ],
    ]) func aSeaWhereTheNavyCantReachUsIsSafe(sea: [[Character]]) {
        #expect(isThisASafeRoute(in: sea) == true)
    }

    @Test("we should not take this route, because its unsafe", arguments: [
        [
            ["X","N"]
        ], // Unsafe, because navy is too close in turn 1
        [
            ["X","0"],
            ["0","N"]
        ], // Unsafe, because navy is too close in turn 1
        [
            ["0", "N"],
            ["X", "0"]
        ],
        [
            ["N", "N"],
            ["X", "N"]
        ]
    ])

    func anUnsafeRouteOf1x2WithNavy(sea: [[Character]]) {
        #expect(isThisASafeRoute(in: sea) == false)
    }
}
