import Foundation

public enum PathElement {
    case selector(String)
    case className(String)
    case attributte(String)
    case identifier(String)
    case parent
    case sibling
    case content
    case children
    case text
}
