import Foundation

public protocol HasFileProvider {
    var fileProvider: AnyProvider<(data: Data, url: URL)> { get }
}
