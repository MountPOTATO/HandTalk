//
//  CameraView.swift
//  HandTalk
//
//  Created by mount_potato on 2021/11/28.
//

import SwiftUI


enum SignSearchState{
    case searching
    case found
}



struct CameraRepresentable: UIViewControllerRepresentable{
    
    var letterString: String
    var isFrontCamera: Bool
    
    //搜索状态和找到字母状态
    @Binding var searchState: SignSearchState
    
    //当前找到的字母，默认为"nothiing"
    @Binding var currentLetter: String
    
    
    func makeUIViewController(context: Context) -> CameraVC {
        let controller = CameraVC(sign: letterString, isFrontCamera: isFrontCamera)
        
        controller.delegate = context.coordinator
        return controller
    }
    
    func updateUIViewController(_ uiViewController: CameraVC, context: Context) {
        
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(searchState: $searchState, currentLetter: $currentLetter)
    }
    
    class Coordinator: NSObject, UINavigationControllerDelegate, SignDetectedDelegate {
        
        @Binding var searchState: SignSearchState
        @Binding var currentLetter: String
        
        init(searchState: Binding<SignSearchState>, currentLetter: Binding<String>) {
            _searchState = searchState
            _currentLetter = currentLetter
            
        }
        
        func foundSign(result: Bool) {
            print("Sign Detected \(result)")
            searchState = .found
        }
        
        func passValueToRepresentable(letter: String){
            currentLetter = letter
        }
        

    }
}




struct RecognizeCameraView: View {
    

    
    @State var searchState = SignSearchState.searching
    
    @State var currentLetter: String = "nothing"
    
    
    var body: some View {
        
            
            VStack{
                
                Text("Recognize their sign language")
                    .font(.headline)
                    .lineLimit(3)
                    .multilineTextAlignment(.leading)
                    .padding(10)
                    .padding(.horizontal, 10)
                    .background(FaintView().cornerRadius(25))
                    .minimumScaleFactor(0.5)
                    .lineLimit(1)
                    .frame(width: 300)
                
                CameraRepresentable(letterString: "scan-mode", isFrontCamera: false, searchState: $searchState, currentLetter: $currentLetter)

                
                Text(currentLetter+" is detected.")
                    .font(.headline)
                    .lineLimit(3)
                    .multilineTextAlignment(.leading)
                    .padding(10)
                    .padding(.horizontal, 10)
                    .background(FaintView().cornerRadius(25))
                    .minimumScaleFactor(0.5)
                    .lineLimit(1)
                    .frame(width: 300)
                
                
            }

        
       
    }
}

struct CameraView_Previews: PreviewProvider {
    static var previews: some View {
        RecognizeCameraView()
    }
}
