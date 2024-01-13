//
//  Message.swift
//  Hizmet Burada
//
//  Created by turan on 9.01.2024.
//

import Foundation


struct Message : Codable  {
    var senderID: String
    var receiverID: String
    var text: String
    var timestamp: Double
    var price : String
    
    
    enum CodingKeys: String, CodingKey {
        case senderID
        case receiverID
        case text
        case timestamp
        case price
        
    }
    
    func toDictionarym() -> [String: Any] {
        return [
            "senderID": senderID,
            "receiverID": receiverID,
            "text": text,
            "timestamp": timestamp,
            "price": price
        ]
    }
  
}
