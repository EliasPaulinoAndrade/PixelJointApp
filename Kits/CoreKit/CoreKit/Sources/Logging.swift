public protocol Logging {
    func log(_ loggable: Loggable)
    func log(_ loggable: Loggable, _ category: LogCategory)
}

public protocol Loggable {
    var logDescription: String { get }
}

public protocol LogCategory {
    var identifier: String { get }
}

public enum UILog: String, LogCategory {
    public var identifier: String {
        return "UI \(rawValue.uppercased())"
    }
    
    case message
    case warning
    case critical
}

extension String: Loggable {
    public var logDescription: String {
        return self
    }
}

public struct ConsoleLogger: Logging {
    public init() { }
    public func log(_ loggable: Loggable) {
        print(loggable.logDescription)
    }
    
    public func log(_ loggable: Loggable, _ category: LogCategory) {
        print("\(category.identifier) - \(loggable.logDescription)")
    }
}

