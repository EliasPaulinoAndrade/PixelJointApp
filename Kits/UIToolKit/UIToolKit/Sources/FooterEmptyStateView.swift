import SwiftUI

public struct FooterEmptyStateView: View {
    @Binding var isLoading: Bool
    @Binding var isShowingError: Bool
    @Binding var hasNoMoreContent: Bool
    let errorTitle: String
    let retryTitle: String
    @Binding var noContentTitle: String
    let retryAction: (() -> Void)?
    var onErrorAppearCompletion: (() -> Void)?
    
    public var body: some View {
        ZStack {
            if isLoading {
                ProgressView()
            } else if isShowingError {
                VStack {
                    Text(errorTitle)
                        .foregroundColor(Color(UIToolKitAsset.Assets.text.color))
                    Button(
                        action: {
                            retryAction?()
                        },
                        label: {
                            VStack {
                                Text(retryTitle)
                                Image(systemName: "arrow.counterclockwise")
                            }
                        }
                    ).foregroundColor(Color(UIToolKitAsset.Assets.link.color))
                }.onAppear {
                    onErrorAppearCompletion?()
                }
            } else if hasNoMoreContent {
                Text(noContentTitle)
                    .foregroundColor(Color(UIToolKitAsset.Assets.text.color))
            }
        }
    }
    
    public init(isLoading: Binding<Bool>,
                isShowingError: Binding<Bool>,
                hasNoMoreContent: Binding<Bool>,
                errorTitle: String,
                retryTitle: String,
                noContentTitle: Binding<String>,
                retryAction: (() -> Void)?) {
        self._isLoading = isLoading
        self._isShowingError = isShowingError
        self._hasNoMoreContent = hasNoMoreContent
        self.errorTitle = errorTitle
        self.retryTitle = retryTitle
        self._noContentTitle = noContentTitle
        self.retryAction = retryAction
    }
    
    public func onErrorAppear(_ perform: @escaping () -> Void) -> Self {
        var selfCopy = self
        selfCopy.onErrorAppearCompletion = perform
        return selfCopy
    }
}
