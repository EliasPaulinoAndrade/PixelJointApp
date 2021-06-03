import Foundation

public protocol ViewCodable {
    func buildHierarchy()
    func addConstraints()
    func configureView()
}

public extension ViewCodable {
    func buildHierarchy() { }
    func addConstraints() { }
    func configureView() { }
    func buildView() {
        buildHierarchy()
        addConstraints()
        configureView()
    }
}
