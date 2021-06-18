import Foundation

public protocol HTMLDecodable {
    init(container: HTMLContaining) throws
}
