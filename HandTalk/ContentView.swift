//
//  ContentView.swift
//  HandTalk
//
//  Created by mount_potato on 2021/11/28.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView{
            HomePageView()
                .tabItem {
                    Text("Home")
                    Image(systemName: "house.fill")
                    
                }
            RecognizeCameraView()
                .tabItem {
                    Text("Recognize")
                    Image(systemName: "camera.fill")
                    
                }
            AlphabetView()
                .tabItem {
                    Text("Alphabet")
                    Image(systemName: "hand.point.right.fill")
                }
        }
         
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
