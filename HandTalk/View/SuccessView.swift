//
//  SuccessView.swift
//  HandTalk
//
//  Created by mount_potato on 2021/12/1.
//

import SwiftUI

struct SuccessView: View {
    var body: some View {
        
        GeometryReader{proxy in
            
            let width = proxy.size.width
            let height = proxy.size.height
            
            VStack(alignment: .center){
                Image(systemName: "checkmark.seal.fill")
                    .resizable()
                    .frame(width: width/2, height: width/2, alignment: .center)
                    .cornerRadius(20).clipped()
                    .foregroundColor(.green)
                
                Text("Excellent work!")
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
            .frame(width: width, height: height, alignment: .center)
        }
            

    }
}

struct SuccessView_Previews: PreviewProvider {
    static var previews: some View {
        SuccessView()
    }
}
