//
//  workModel.swift
//  Hizmet Burada
//
//  Created by turan on 10.11.2023.
//

import Foundation

struct WorkModel : Codable{
    var imageUrl : String
    var workName  :String
    var id : Int
    
    enum CodingKeys: String, CodingKey {
        case imageUrl
        case workName
        case id
        // Diğer özelliklerin CodingKeys tanımlamaları
    }
    
}
