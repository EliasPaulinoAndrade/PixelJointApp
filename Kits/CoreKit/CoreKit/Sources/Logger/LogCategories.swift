import Foundation

public enum LogicalLog: String, LogCategory {
    public var identifier: String {
        return "Logical \(rawValue.uppercased())"
    }
    
    case message
    case critical
}

public enum UILog: String, LogCategory {
    public var identifier: String {
        return "UI \(rawValue.uppercased())"
    }
    
    case message
    case warning
    case critical
}
