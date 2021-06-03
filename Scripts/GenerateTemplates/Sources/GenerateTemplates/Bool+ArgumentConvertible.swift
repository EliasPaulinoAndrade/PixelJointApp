import Commander

extension Bool: ArgumentConvertible {
    public init(parser: ArgumentParser) throws {
        guard let boolValue = parser.shift() else {
            throw ArgumentError.missingValue(argument: nil)
        }
        
        switch boolValue.lowercased() {
        case "true":
            self = true
        case "false":
            self = false
        default:
            throw ArgumentError.invalidType(value: boolValue, type: "Bool", argument: nil)
        }
        
        self = boolValue.lowercased() == "true"
    }
}
