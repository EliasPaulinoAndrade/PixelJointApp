import SwiftUI
import UIToolKit

private struct ItemsWidthsKey: PreferenceKey {
    static var defaultValue: [CGFloat] = []

    static func reduce(value: inout [CGFloat], nextValue: () -> [CGFloat]) {
        value.append(contentsOf: nextValue())
    }
}

private struct ItemsTotalWidthKey: PreferenceKey {
    static var defaultValue: CGFloat = .zero

    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value += nextValue()
    }
}

private struct StackHeightKey: PreferenceKey {
    static var defaultValue: CGFloat = .zero

    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) { }
}

struct ScrollableSelectionView<DataType: Identifiable,
                               ItemType: View>: View {
    
    private let aligmentMode: AligmentMode
    private let models: [DataType]
    @ViewBuilder private let itemBuilder: (DataType, Bool) -> ItemType
    @Binding private var selected: DataType
    @State private var focused: DataType
    
    init(models: [DataType],
         aligmentMode: AligmentMode = .left,
         selected: Binding<DataType>,
         itemBuilder: @escaping (DataType, Bool) -> ItemType) {
        self.models = models
        self.itemBuilder = itemBuilder
        self._selected = selected
        self.aligmentMode = aligmentMode
        self._focused = State(initialValue: selected.wrappedValue)
    }
 
    var body: some View {
        ScrollableFocusableView(models: models,
                                aligmentMode: aligmentMode,
                                focused: $focused) { model in
            itemBuilder(model, model.id == selected.id)
                .onTapGesture {
                    if model.id != selected.id {
                        selected = model
                        focused = model
                    }
                }
        }.onChange(of: selected.id) { selectedID in
            let selectedItem = models.first { $0.id == selectedID }
            guard let selectedItem = selectedItem else {
                return
            }
            focused = selectedItem
        }
    }
}

extension Comparable {
    func clamped(to limits: ClosedRange<Self>) -> Self {
        return min(max(self, limits.lowerBound), limits.upperBound)
    }
}
