//
//  AlphabetView.swift
//  HandTalk
//
//  Created by mount_potato on 2021/11/28.
//

import SwiftUI
import Vision
import AVFoundation


let alphabetList=[
    "A","B","C","D","E","F","G","H","I","J",
    "K","L","M","N","O","P","Q","R","S","T",
    "U","V","W","X","Y","Z"
]



struct CardView: View{
    
    let letter:String
    
    var body: some View{
        Image(letter)
            .resizable()
            
    }
}


struct AlphabetView: View {
    
    
    @ObservedObject var viewModel: AlphabetViewModel = AlphabetViewModel()
    

    @State private var cameraViewIsPresented = false
    
    var body: some View {
        GeometryReader{ proxy in
            
            let width = proxy.size.width
            let height = proxy.size.width

//            NavigationView{
                
                Form{
                    
                    Section{
                        Text("American Sign Language")
                            .font(.headline)
                            .fontWeight(.bold)
                            .minimumScaleFactor(0.5)
                            .lineLimit(1)
                        Text("American Sign Language (ASL) is a complete, natural language that has the same linguistic properties as spoken languages, with grammar that differs from English. ASL is expressed by movements of the hands and face. It is the primary language of many North Americans who are deaf and hard of hearing and is used by some hearing people as well.")
                    }
                    .cornerRadius(5).clipped()
                    
                    Section{
                        ScrollView(.horizontal){
                            HStack{
                                ForEach(alphabetList, id:\.self){ letter in
                                    
                                    Button(action: {
                                        self.cameraViewIsPresented = true
                                        viewModel.changeCurrentLetter(letter: letter)
                                    }, label: {
                                        CardView(letter: letter)
                                            .frame(width: width/4, height: height/2.5, alignment: .center)
                                    }).sheet(isPresented: $cameraViewIsPresented, content: {
                                        AlphaBetCameraView(viewModel: viewModel)
                                    })
              
                                }
                            }
                        }
                        
                        Text("Click to activate camera to practice ASL.")
                            .frame(alignment:.center)
                            .minimumScaleFactor(0.5)
                            .scaledToFill()
                            .lineLimit(1)
                        

                    }
                    .cornerRadius(5).clipped()
                    

                    
                    


                
            }
        }
    }
}


struct AlphaBetCameraView: View{
    
    @Environment(\.presentationMode) var presentationMode
    
    @State var searchState = SignSearchState.searching
    @State var currentLetter: String = ""
    @ObservedObject var viewModel: AlphabetViewModel
    
    
    var body: some View{
        
        GeometryReader{ proxy in 
            let width = proxy.size.width
            let height = proxy.size.height
            
            VStack{
                
                let targetLetter = viewModel.getCurrentLetter()
                
                if searchState != .found{
                    Text("Try to make "+targetLetter+" sign yourself! Click somewhere else to cancel.")
                        .font(.headline)
                        .lineLimit(3)
                        .multilineTextAlignment(.leading)
                        .padding(10)
                        .padding(.horizontal, 10)
                        .background(FaintView().cornerRadius(25))
                        .minimumScaleFactor(0.5)
                        .lineLimit(1)
                        .frame(width: 300)
                    
                    CameraRepresentable(letterString: targetLetter, isFrontCamera: true, searchState: $searchState, currentLetter: $currentLetter)
                        .frame(width: width, height: height, alignment: .center)
                    
                    
                }
                else{
                    SuccessView()

                }
            }
            .onTapGesture(count: 1) {
                self.presentationMode.wrappedValue.dismiss()
                self.searchState = .searching
                self.viewModel.changeCurrentLetter(letter: "")
            }
            .edgesIgnoringSafeArea(.all)
            
        }
        
        
    }
}




struct AlphabetView_Previews: PreviewProvider {
    static var previews: some View {
        AlphabetView()
    }
}
