import Foundation

struct AnimationState {
    var isAnimating: Bool = false
    var completions: [() -> Void] = []
}
