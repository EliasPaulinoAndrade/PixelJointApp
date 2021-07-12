import SwiftUI

struct RoundedShape: Shape {
    private let radius: CGFloat
    private let corners: UIRectCorner
    
    public init(radius: CGFloat, corners: UIRectCorner = .allCorners) {
        self.radius = radius
        self.corners = corners
    }

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
    }
}

public protocol ViewStyle {
    associatedtype ViewType: View
    associatedtype StyledViewType: View
    func applyInTo(view: ViewType) -> StyledViewType
}

public struct RoundedViewStyle<ViewType: View>: ViewStyle {
    private let radius: CGFloat
    private let corners: UIRectCorner
    
    public init(radius: CGFloat = 4, corners: UIRectCorner = .allCorners) {
        self.radius = radius
        self.corners = corners
    }
    
    public func applyInTo(view: ViewType) -> some View {
        view.background(Color(Colors.background1.color))
            .clipShape(RoundedShape(radius: radius, corners: corners))
    }
}

public extension View {
    func stylized<ViewStyleType: ViewStyle>(
        _ style: ViewStyleType
    ) -> ViewStyleType.StyledViewType where ViewStyleType.ViewType == Self {
        style.applyInTo(view: self)
    }
}
