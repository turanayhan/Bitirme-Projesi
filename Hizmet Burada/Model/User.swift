//
//  User.swift
//  Hizmet Burada
//
//  Created by turan on 15.11.2023.
//

import Foundation

struct User: Codable {
    var name: String?
    var surname: String?
    var gsm: String?
    var email: String?
    
    enum CodingKeys: String, CodingKey {
        case name
        case surname
        case gsm
        case email
    }
}
