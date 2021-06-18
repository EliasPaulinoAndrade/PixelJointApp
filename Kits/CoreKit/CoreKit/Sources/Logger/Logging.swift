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
