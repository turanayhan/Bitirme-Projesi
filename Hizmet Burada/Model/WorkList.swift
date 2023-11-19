//
//  hizmetlist.swift
//  Hizmet Burada
//
//  Created by turan on 12.11.2023.
//

import Foundation


struct WorkList:Codable{
    
    var veri : [ItemModel]
    
    enum CodingKeys: String, CodingKey {
        case veri
    

    }
    
}
