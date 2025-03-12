//
//  Settings.swift
//  SightSeeStalker
//
//  Created by Danya Polyakov on 11.03.2025.
//

import UIKit

class SettingsModel: Decodable {
    var id: Int?
    var name: String?
    var tag: String?
    var status: String?
    var avatar: String?
    
    init (id: Int, name: String, tag: String, status: String, avatar: UIImage?) {
        self.id = id
        self.name = name
        self.tag = tag
        self.status = status
        self.avatar = nil
    }
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case tag = "tag"
        case status = "status"
        case avatar = "avatar"
    }
}

class SettingsResponse: Decodable {
    let user: SettingsModel
    
    init(user: SettingsModel) {
        self.user = user
    }
}


