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
    var adress : String
    var announcementDate : String?
    var reservationDate : String?

   
    enum CodingKeys: String, CodingKey {
        case nameSurname
        case detail
        case id
        case information
        case message
        case adress
        case announcementDate
        case reservationDate
    }
    
    
    
    func toDictionary() -> [String: Any] {
        return [
            "nameSurname": nameSurname,
            "detail": detail,
            "id": id,
            "information": information,
            "adress":adress,
            "message": message?.map { $0.toDictionarym()},
            "announcementDate":date(),
            "reservationDate" : reservationDate
        ]
    }
    
    func toMessage(veri : [String: Any]){
        
        
    }
    
    func date ()->String{
        
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d MMMM yyyy" // Gün Ay(Yazıyla) Yıl formatı
        dateFormatter.locale = Locale(identifier: "tr_TR") // Türkçe ay isimleri için dil ayarı
        let todayDate = dateFormatter.string(from: date)
        return todayDate
        
    }
    
}



