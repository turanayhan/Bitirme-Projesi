//
//  ChatFile.swift
//  Hizmet Burada
//
//  Created by turan on 24.10.2024.
//

import Foundation

struct ChatModel {
    let chatID: String
    let participants: [String]
    let timestamp: Date
}


struct ChatWithUsersModel {
    let chat: ChatModel
    let participantsInfo: [User]
}
