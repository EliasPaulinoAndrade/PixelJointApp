import SwiftUI

protocol InspectorPresenting: AnyObject {
    // Add methods that interactor should call
    func showText(_ name: String)
}

final class InspectorViewController: ObservableObject {
    weak var interactor: InspectorInteracting?
    @Published var name: String = "Tap To Generate"
}

struct InspectorView: View {
    @ObservedObject var controller: InspectorViewController
    
    var body: some View {
        ZStack {
            VStack {
                Text(controller.name)
                    .foregroundColor(Color.white)
                    .font(.title)
                    .padding()
                Button("Generate Number") {
                    controller.interactor?.getNumber()
                }
                .font(.title3.bold())
            }.frame(maxWidth: .infinity, maxHeight: .infinity)
             .background(Color.black)
            
            VStack {
                HStack {
                    Spacer()
                    Button(
                        action: {
                            controller.interactor?.closeButtonTapped()
                        },
                        label: {
                            Circle()
                                .strokeBorder(Color.white, lineWidth: 2)
                                .background(Image(systemName: "xmark").foregroundColor(.white))
                                .frame(width: 30, height: 30)
                        }
                    )
                }
                Spacer()
            }.padding(10)
        }
         
    }
}

extension InspectorViewController: InspectorPresenting {
    // InspectorViewable methods
    
    func showText(_ name: String) {
        self.name = name
    }
}
