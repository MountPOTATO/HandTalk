//
//  AlphabetPageViewModel.swift
//  HandTalk
//
//  Created by mount_potato on 2021/11/29.
//

import Foundation

class AlphabetViewModel: ObservableObject {
    
    var currentLetter: String = ""
    
    func changeCurrentLetter(letter: String){
        
        self.currentLetter = letter
    }
    
    func getCurrentLetter()->String{
        return self.currentLetter
    }
    
    func cameraShouldOn()->Bool{
        return self.currentLetter != ""
    }
    
    func turnOffCamera(){
        self.currentLetter = ""
    }
    
}
