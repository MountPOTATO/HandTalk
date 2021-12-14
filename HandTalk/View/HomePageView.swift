//
//  HomePageView.swift
//  HandTalk
//
//  Created by mount_potato on 2021/11/28.
//

import SwiftUI




struct ReasonView: View{
    
    let imageSystemName: String
    let reasonText: String
    let imageColor: Color?
    let width: CGFloat
    let height:CGFloat
    
    
    var body: some View{

            HStack{
                Image(systemName: imageSystemName)
                    .resizable()
                    .frame(width:width/20, height: width/20, alignment: .center)
                    .padding(width/100)
                    .foregroundColor(imageColor)
                    .cornerRadius(20).clipped()
                VStack(alignment: .leading, spacing: 2){
                    Text(reasonText)
                        .padding(.leading,4)
                        .scaledToFill()
                        .lineLimit(1)
                }
         
            }

    }
}






struct HomePageView: View {
    var body: some View {
        GeometryReader{ proxy in
            
            let width = proxy.size.width
            let height = proxy.size.height

                
  
            Form{
                
                Section{
                    Text("Get along with people with disablity")
                        .font(.headline)
                        .fontWeight(.bold)
                        .minimumScaleFactor(0.5)
                        .lineLimit(1)
                    CarouselView()
                        .frame(height: width/2.5, alignment: .center)
                }
                                
                Section{
                    
                    HStack{
                        Image(systemName: "hand.draw")
                            .resizable()
                            .frame(width:width/7, height: width/7, alignment: .center)
                            .padding(2)
                            .cornerRadius(20).clipped()
                        VStack(alignment: .leading, spacing: 2){
                            Text("Hand talks. ")
                                .font(.largeTitle)
                                .minimumScaleFactor(0.5)
                                .lineLimit(1)
                            Text("Some reasons to learn ASL")
                                .minimumScaleFactor(0.5)
                            
                                .lineLimit(1)
                        }.padding(.leading, 2)
                        
                    }

                    
                    VStack(alignment:.leading){

                        ReasonView(imageSystemName: "person.2", reasonText: "Companion to close one in need", imageColor: .blue,width: width,height: height/12)
                            .padding(.bottom,2)
                        

                        ReasonView(imageSystemName: "figure.stand.line.dotted.figure.stand", reasonText: "Social assistance to spread love", imageColor: .purple,width: width,height: height/12)
                            .padding(.bottom,2)

                        ReasonView(imageSystemName: "cross.case",
                                   reasonText:
                                    "Vital medical interact method", imageColor: .red
                                   ,width: width,height: height/12)
                            .padding(.bottom,2)

                        ReasonView(imageSystemName: "mic.slash",
                                   reasonText:
                                    "Emergency information approach ", imageColor: .gray,width: width,height: height/12)
                            .padding(.bottom,2)


                        ReasonView(imageSystemName: "brain.head.profile",
                                   reasonText:
                                    "Communication with mental disabled", imageColor: .orange,width: width,height: height/12)
                            .padding(.bottom,2)
   
                    }
               
                }
                .cornerRadius(5).clipped()

                

            }
        }
    }
}




struct HomePageView_Previews: PreviewProvider {
    static var previews: some View {
        HomePageView()
    }
}
