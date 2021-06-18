import Foundation

public struct ConsoleLogger: Logging {
    public init() { }
    public func log(_ loggable: Loggable) {
        print(loggable.logDescription)
    }
    
    public func log(_ loggable: Loggable, _ category: LogCategory) {
        print("\(category.identifier) - \(loggable.logDescription)")
    }
}
