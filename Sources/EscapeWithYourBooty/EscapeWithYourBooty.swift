@main struct EscapeWithYourBooty {
    static func main() {
        
    }
}

func isThisASafeRoute(in sea: [[Character]]) -> Bool {
    // lets assume that any route with Navy is unsafe
    sea.contains { row in
        row.contains("N")
    }  == false
}
