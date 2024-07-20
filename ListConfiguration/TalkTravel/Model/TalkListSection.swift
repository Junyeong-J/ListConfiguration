//
//  TalkListSection.swift
//  ListConfiguration
//
//  Created by 전준영 on 7/20/24.
//

import Foundation

enum TalkListSection: CaseIterable {
    case main
}

struct ChatRoom: Hashable {
    let chatroomId: Int
    let chatroomImage: [String]
    let chatroomName: String
    var chatList: [Chat] = []
}

struct Chat: Hashable {
    let user: User
    let date: String
    let message: String
}

enum User: String, Hashable {
    case hue = "Hue"
    case jack = "Jack"
    case bran = "Bran"
    case den = "Den"
    case user
    case other_friend = "내옆자리의앞자리에개발잘하는친구"
    case simsim = "심심이"
    
    var profileImage: String {
        switch self {
        default: return rawValue
        }
    }
}
