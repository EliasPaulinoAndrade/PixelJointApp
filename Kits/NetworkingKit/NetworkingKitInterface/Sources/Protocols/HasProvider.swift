import Foundation

public protocol HasFileProvider {
    var fileProvider: AnyProvider<Data> { get }
}
