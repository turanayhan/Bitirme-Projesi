//
//  JobModel.swift
//  Hizmet Burada
//
//  Created by turan on 9.01.2024.
//

import Foundation
 
struct JobModel : Codable{
    
    var nameSurname : String
    var detail : String
    var id : String
    var information:[String:String] = [:]
    var message : [Message]?
   
    enum CodingKeys: String, CodingKey {
        case nameSurname
        case detail
        case id
        case information
        case message
    }
    
    
    
    func toDictionary() -> [String: Any] {
        return [
            "nameSurname": nameSurname,
            "detail": detail,
            "id": id,
            "information": information,
            "message": message?.map { $0.toDictionarym() }
        ]
    }
    
    func toMessage(veri : [String: Any]){
        
        
    }
    
}



