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
    
    @Test("we should not take this route, because its unsafe") func anUnsafeRouteOf1x2WithNavy() {
        let sea: [[Character]] = [["X","N"]]
        #expect(isThisASafeRoute(in: sea) == false)
    }
}
