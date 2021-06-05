import UIKit
import SwiftUI

protocol InitialPresenting: AnyObject {
    // Add methods that interactor should call
}

//final class InitialViewController: UIViewController {
//    weak var interactor: InitialInteracting?
//}

final class InitialViewController: ObservableObject {
    weak var interactor: InitialInteracting?
}

struct InitialView: View {
    @ObservedObject var controller: InitialViewController
    
    var body: some View {
        ZStack {
            VStack {
                Text("Pucca")
                    .foregroundColor(Color.white)
                    .font(.title)
                    .padding()
            }.frame(maxWidth: .infinity, maxHeight: .infinity)
             .background(Color.black)
            VStack {
                HStack {
                    Spacer()
                    Button(
                        action: {
                            controller.interactor?.userTappedClose()
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

extension InitialViewController: InitialPresenting {
 
}
