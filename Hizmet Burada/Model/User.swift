//
//  User.swift
//  Hizmet Burada
//
//  Created by turan on 15.11.2023.
//

import Foundation

struct User: Codable {
    var username: String
    var email: String
    
    enum CodingKeys: String, CodingKey {
        case username
        case email
    
      
    }
}
