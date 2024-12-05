import Testing
@testable import EscapeWithYourBooty

@Suite("To make sure we get our bounty safely to shore") struct EscapeWithYourBootyTests {
    @Test("we should know that a 1x1 sea without any navy is safe") func aSafeRouteOf1x1WithoutNavy() {
        let sea: [[Character]] = [["X"]]
        #expect(isThisASafeRoute(in: sea) == true)
    }
}
