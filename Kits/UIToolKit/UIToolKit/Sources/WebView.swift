import SwiftUI
import UIKit
import WebKit
import Foundation

private struct HTMLWebView: UIViewRepresentable {
    @Binding var dynamicHeight: CGFloat
    let htmlString: String
    let textColor: UIColor
    let linkColor: UIColor
    let font: UIFont
    
    var onUserNavigateAction: ((WKNavigationAction, URL) -> WKNavigationActionPolicy)?

    func makeCoordinator() -> Coordinator {
        let coordinator = Coordinator(self)
        coordinator.onUserNavigateAction = userDidNavigate
        return coordinator
    }

    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.scrollView.isScrollEnabled = false
        webView.scrollView.bounces = false
        webView.navigationDelegate = context.coordinator
        webView.isOpaque = false
        webView.scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        webView.scrollView.contentInsetAdjustmentBehavior = .never
        
        let textRGB = textColor.rgb ?? .empty
        let linkRGB = linkColor.rgb ?? .empty
        let fontFamily = font.fontDescriptor.fontAttributes[.textStyle] as? String ?? ""
        let fontSize = font.fontDescriptor.fontAttributes[.size] as? CGFloat ?? 0.0
        
        let completeHTML = UIToolKitStrings.html(
            fontFamily,
            fontSize,
            textRGB.red, textRGB.green, textRGB.blue,
            linkRGB.red, linkRGB.green, linkRGB.blue,
            htmlString
        )
    
        webView.loadHTMLString(completeHTML, baseURL: nil)
        return webView
    }

    func updateUIView(_ uiView: WKWebView, context: Context) { }
    
    private func userDidNavigate(action: WKNavigationAction, url: URL) -> WKNavigationActionPolicy {
        guard let navigateAction = onUserNavigateAction else {
            return .cancel
        }
        return navigateAction(action, url)
    }
    
    func onUserNavigate(perform: ((WKNavigationAction, URL) -> WKNavigationActionPolicy)?) -> Self {
        var selfCopy = self
        
        selfCopy.onUserNavigateAction = perform
        
        return selfCopy
    }
}

private extension HTMLWebView {
    class Coordinator: NSObject, WKNavigationDelegate {
        var parent: HTMLWebView
        var onUserNavigateAction: ((WKNavigationAction, URL) -> WKNavigationActionPolicy)?

        init(_ parent: HTMLWebView) {
            self.parent = parent
        }
        
        func webView(_ webView: WKWebView,
                     decidePolicyFor navigationAction: WKNavigationAction,
                     decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
            guard let navigateAction = onUserNavigateAction,
                  let url = navigationAction.request.url,
                  navigationAction.targetFrame == nil else {
                return decisionHandler(.allow)
            }
            
            decisionHandler(navigateAction(navigationAction, url))
        }

        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            webView.evaluateJavaScript("document.documentElement.scrollHeight") { height, _ in
                DispatchQueue.main.async {
                    self.parent.dynamicHeight = height as? CGFloat ?? 0.0
                }
            }
        }
    }
}

public struct WebView: View {
    let text: String
    let textColor: UIColor
    let font: UIFont
    let linkColor: UIColor
    private var onUserNavigateAction: ((WKNavigationAction, URL) -> WKNavigationActionPolicy)?
    @State var webViewHeight: CGFloat = .zero
    
    public init(text: String, textColor: UIColor, linkColor: UIColor, font: UIFont) {
        self.text = text
        self.textColor = textColor
        self.linkColor = linkColor
        self.font = font
    }
    
    public var body: some View {
        HTMLWebView(
            dynamicHeight: $webViewHeight,
            htmlString: text,
            textColor: textColor,
            linkColor: linkColor,
            font: font
        ).onUserNavigate(perform: userDidNavigate)
         .frame(height: webViewHeight)
         .background(Color.clear)
    }
    
    private func userDidNavigate(action: WKNavigationAction, url: URL) -> WKNavigationActionPolicy {
        guard let navigateAction = onUserNavigateAction else {
            return .cancel
        }
        return navigateAction(action, url)
    }
    
    public func onUserNavigate(perform: ((WKNavigationAction, URL) -> WKNavigationActionPolicy)?) -> Self {
        var selfCopy = self
        
        selfCopy.onUserNavigateAction = perform
        
        return selfCopy
    }
}

public extension UIColor {
    struct RGB {
        let red: Int
        let green: Int
        let blue: Int
        let alpha: Int
        
        static var empty: RGB {
            RGB(red: 0, green: 0, blue: 0, alpha: 0)
        }
    }
    
    var rgb: RGB? {
        var redValue: CGFloat = 0
        var greenValue: CGFloat = 0
        var blueValue: CGFloat = 0
        var alphaValue: CGFloat = 0
        
        guard getRed(&redValue, green: &greenValue, blue: &blueValue, alpha: &alphaValue) else {
            return nil
        }
        return RGB(
            red: Int(redValue * 255.0),
            green: Int(greenValue * 255.0),
            blue: Int(blueValue * 255.0),
            alpha: Int(alphaValue * 255.0)
        )
    }
}
