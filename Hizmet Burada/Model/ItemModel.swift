//
//  ItemModel.swift
//  Hizmet Burada
//
//  Created by turan on 10.11.2023.
//

import Foundation


struct ItemModel : Codable{
    
    var header : String
    var workList : [WorkModel]
    
    enum CodingKeys: String, CodingKey {
        case header
        case workList
    }
}
