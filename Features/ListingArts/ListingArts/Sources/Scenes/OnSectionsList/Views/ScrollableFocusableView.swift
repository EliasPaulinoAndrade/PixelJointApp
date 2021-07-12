import Foundation
import SwiftUI
import UIToolKit

private struct ItemsOffsetsKey: PreferenceKey {
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

enum AligmentMode {
    case left
    case center
}

struct ScrollableFocusableView<DataType: Identifiable,
                               ItemType: View>: View {
    
    private let allowsDrag: Bool
    private let aligmentMode: AligmentMode
    private let models: [DataType]
    private let spacing: CGFloat
    @ViewBuilder private let itemBuilder: (DataType) -> ItemType
    @Binding private var focused: DataType
    @State private var scrollOffset: CGFloat = .zero
    @State private var acamulatedOffset: CGFloat = .zero
    @State private var stackHeight: CGFloat = .zero
    @State private var itemsTotalWidth: CGFloat = .zero
    @State private var itemsOffsets: [CGFloat] = []
    @State private var stackScale: CGFloat = 1
    
    init(models: [DataType],
         aligmentMode: AligmentMode = .left,
         allowsDrag: Bool = true,
         spacing: CGFloat = 0,
         focused: Binding<DataType>,
         @ViewBuilder itemBuilder: @escaping (DataType) -> ItemType) {
        self.models = models
        self.itemBuilder = itemBuilder
        self._focused = focused
        self.aligmentMode = aligmentMode
        self.allowsDrag = allowsDrag
        self.spacing = spacing
    }
 
    var body: some View {
        GeometryReader { contextGeometry in
            HStack(spacing: spacing) {
                ForEach(models) { model in
                    itemBuilder(model)
                        .background(
                            GeometryReader { itemGeometry in
                                Color.clear
                                    .preference(
                                        key: ItemsTotalWidthKey.self,
                                        value: itemGeometry.size.width
                                    )
                                    .preference(
                                        key: ItemsOffsetsKey.self,
                                        value: {
                                            switch aligmentMode {
                                            case .left:
                                                return [itemGeometry.frame(in: .named("stackSpace")).minX]
                                            case .center:
                                                return [itemGeometry.frame(in: .named("stackSpace")).midX]
                                            }
                                        }()
                                    )
                            }
                        )
                        .id(model.id)
                        .onChange(of: focused.id) { selectedID in
                            animateToItem(
                                withID: selectedID,
                                maximumOffset: itemsTotalWidth - contextGeometry.size.width,
                                contextWidth: contextGeometry.size.width
                            )
                        }
                }
            }.scaleEffect(stackScale)
            .coordinateSpace(name: "stackSpace")
            .background(
                GeometryReader { stackGeometry in
                    Color.clear.preference(
                        key: StackHeightKey.self,
                        value: stackGeometry.size.height
                    )
                }
            )
            .offset(x: scrollOffset)
            .gesture(
                DragGesture()
                    .onChanged { dragValue in
                        guard allowsDrag else { return }
                        scrollOffset = dragValue.translation.width + acamulatedOffset
                    }.onEnded { dragValue in
                        guard allowsDrag else { return }
                        let endOffset = dragValue.predictedEndTranslation.width + acamulatedOffset
                        let maximumOffset = itemsTotalWidth - contextGeometry.size.width
                        guard let nextItem = ScrollableFocusableView.getNextSnapItem(
                            currentOffset: endOffset,
                            maximumOffset: maximumOffset,
                            itemsOffsets: itemsOffsets,
                            contextWidth: contextGeometry.size.width,
                            aligmentMode: aligmentMode
                        ) else {
                            let endOffset = endOffset.clamped(to: 0...maximumOffset)
                            withAnimation(.spring()) {
                                scrollOffset = endOffset
                                acamulatedOffset = scrollOffset
                            }
                            return
                        }
                        
                        animateToSnappedItem(
                            nextItem,
                            maximumOffset: maximumOffset,
                            contextWidth: contextGeometry.size.width
                        )
                    }
            ).onPreferenceChange(ItemsTotalWidthKey.self) { width in
                itemsTotalWidth = width + spacing * CGFloat(models.count - 1)
            }.onPreferenceChange(ItemsOffsetsKey.self) { widths in
                itemsOffsets = widths
            }.onPreferenceChange(StackHeightKey.self) { height in
                stackHeight = height
            }
        }.frame(height: stackHeight)
         .clipped()
    }
    
    private func animateToSnappedItem(_ index: Int,
                                      maximumOffset: CGFloat,
                                      contextWidth: CGFloat) {
        let item = models[index]
        
        if focused.id == item.id {
            animateToItem(
                withID: item.id,
                maximumOffset: maximumOffset,
                contextWidth: contextWidth
            )
        }
        
        focused = item
    }
    
    private func animateToItem(withID itemID: DataType.ID,
                               maximumOffset: CGFloat,
                               contextWidth: CGFloat) {
        guard let selectedOffset = ScrollableFocusableView.getItemOffset(
            models: models,
            itemsOffsets: itemsOffsets,
            itemID: itemID,
            maximumOffset: maximumOffset,
            contextWidth: contextWidth,
            aligmentMode: aligmentMode
        ) else {
            return
        }
        
        withAnimation(.spring()) {
            scrollOffset = selectedOffset
            acamulatedOffset = scrollOffset
        }
    }
}

private extension ScrollableFocusableView {
    // swiftlint:disable:next function_parameter_count
    static func getItemOffset(models: [DataType],
                              itemsOffsets: [CGFloat],
                              itemID: DataType.ID,
                              maximumOffset: CGFloat,
                              contextWidth: CGFloat,
                              aligmentMode: AligmentMode) -> CGFloat? {
        let selectedPosition = models.firstIndex { model in
            model.id == itemID
        }
        
        guard let selectedPosition = selectedPosition else {
            return nil
        }
        
        let selectedOffset = itemsOffsets[selectedPosition]
        let alignedOffset: CGFloat
        
        switch aligmentMode {
        case .left:
            alignedOffset = selectedOffset
        case .center:
            alignedOffset = selectedOffset - contextWidth/2
        }
        
        let realOffset = alignedOffset.clamped(to: 0...maximumOffset)
        
        return -realOffset
    }

    static func getNextSnapItem(currentOffset: CGFloat,
                                maximumOffset: CGFloat,
                                itemsOffsets: [CGFloat],
                                contextWidth: CGFloat,
                                aligmentMode: AligmentMode) -> Int? {
        let firstIndexAfterCurrentOffset = itemsOffsets
            .enumerated()
            .sorted { firstOffset, secondOffset in
                
            let firstOffsetDifference: CGFloat
            let secondOffsetDifference: CGFloat
            switch aligmentMode {
            case .left:
                firstOffsetDifference = abs(firstOffset.element.distance(to: -currentOffset))
                secondOffsetDifference = abs(secondOffset.element.distance(to: -currentOffset))
            case .center:
                let centerOffset = currentOffset - contextWidth/2
                firstOffsetDifference = abs(firstOffset.element.distance(to: -centerOffset))
                secondOffsetDifference = abs(secondOffset.element.distance(to: -centerOffset))
            }
            
            return firstOffsetDifference < secondOffsetDifference
        }.first?.offset
            
        guard let firstIndexAfterCurrentOffset = firstIndexAfterCurrentOffset else {
            return itemsOffsets.count - 1
        }
                
        return min(firstIndexAfterCurrentOffset, itemsOffsets.count - 1)
    }
    
    static func getOffsetsFrom(itemWidths: [CGFloat]) -> [CGFloat] {
        itemWidths.reduce([0.0]) { currentOffsets, currentWidth in
            guard let lastOffset = currentOffsets.last else {
                return [currentWidth]
            }
            return currentOffsets + [lastOffset + currentWidth]
        }
    }
}
