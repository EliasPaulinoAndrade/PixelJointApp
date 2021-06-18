import Foundation

public typealias RootExternalDepedencing = HasLocalStoraging

public protocol HasLocalStoraging {
    var storage: LocalStoraging { get }
}

public protocol LocalStoraging {
    func save(string: String, for key: String)
    func get(key: String) -> String?
}
