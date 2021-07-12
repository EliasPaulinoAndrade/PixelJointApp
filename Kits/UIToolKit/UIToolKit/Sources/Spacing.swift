import Foundation
import CoreGraphics

public enum Spacing {
    /// 0
    case base0
    
    /// 2
    case base1
    
    /// 4
    case base2
    
    /// 8
    case base3
    
    /// 16
    case base4
    
    /// 32
    case base5
    
    public var value: CGFloat {
        switch self {
        case .base0:
            return 0
        case .base1:
            return 2
        case .base2:
            return 4
        case .base3:
            return 8
        case .base4:
            return 16
        case .base5:
            return 32
        }
    }
}

