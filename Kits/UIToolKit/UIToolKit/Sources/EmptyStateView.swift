import SwiftUI

public struct EmptyStateView: View {
    @Binding var isLoading: Bool
    @Binding var isShowingError: Bool
    let errorTitle: String
    let retryTitle: String
    let retryAction: (() -> Void)?
    let mustShowImage: Bool
    
    public var body: some View {
        if isLoading, !isShowingError {
            ProgressView()
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        } else if isShowingError {
            VStack {
                Spacer()
                if mustShowImage {
                    Image(uiImage: UIToolKitAsset.Assets.networkingErrorIcon.image)
                        .resizable()
                        .renderingMode(.template)
                        .foregroundColor(Color(UIToolKitAsset.Assets.text.color))
                        .frame(width: 30, height: 30)
                }
                Text(errorTitle)
                    .foregroundColor(Color(UIToolKitAsset.Assets.text.color))
                
                ZStack {
                    ProgressView()
                        .opacity(isLoading ? 1 : 0)
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
                     .opacity(isLoading ? 0 : 1)
                }
                Spacer()
            }.frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
    
    public init(isLoading: Binding<Bool>,
                isShowingError: Binding<Bool>,
                errorTitle: String,
                retryTitle: String,
                mustShowImage: Bool = true,
                retryAction: (() -> Void)? = nil) {
        self._isLoading = isLoading
        self._isShowingError = isShowingError
        self.errorTitle = errorTitle
        self.retryTitle = retryTitle
        self.retryAction = retryAction
        self.mustShowImage = mustShowImage
    }
}
