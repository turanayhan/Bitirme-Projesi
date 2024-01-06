//
//  RegistrationInformation.swift
//  Hizmet Burada
//
//  Created by turan on 6.01.2024.
//

import UIKit

class RegistrationInformation {
 
    static let rgİnformation = RegistrationInformation()
    
 
    var name : String?
    var surname : String?
    var gsm : String?
    var locationCity : String?
    var district  : String?
    var neighbourhood : String?
    var answerSelection:[String] = []
    var extraİnformation  :String?
    var mail : String?
    var userİd : String?
    
    
    func addInfo(value:String) {
        answerSelection.append(value)
    
    }
}
