//
//  RegistrationInformation.swift
//  Hizmet Burada
//
//  Created by turan on 6.01.2024.
//

import UIKit

class ServiceProviderRegistration {
 
    static let rgİnformation = ServiceProviderRegistration()
    
 
    var nameSurname : String?
    var gsm : String?
    var adrees : String?
    var answerSelection:[String] = []
    var extraİnformation  :String?
    var mail : String?
    var userİd : String?
    var status : String?
    var profileImage : String?
    
    
    func addInfo(value:String) {
        answerSelection.append(value)
    
    }
}
