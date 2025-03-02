//
//  Person.swift
//  SightSeeStalker
//
//  Created by Danya Polyakov on 21.01.2025.
//

import UIKit

class PersonModel: Decodable {
    var id: Int?
    var name: String?
    var tag: String?
    var status: String?
    var follows: [Int]?
    var followersNum: Int?
    var avatar: String?
    
    init (id: Int, name: String, tag: String, status: String, follows: [Int]?, followersNum: Int, avatar: UIImage?) {
        self.id = id
        self.name = name
        self.tag = tag
        self.status = status
        self.follows = follows
        self.followersNum = followersNum
        self.avatar = nil
    }
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case tag = "tag"
        case status = "status"
        case follows = "follows"
        case followersNum = "followers_num"
        case avatar = "avatar"
    }
}

class PersonResponse: Decodable {
    let user: PersonModel
    
    init(user: PersonModel) {
        self.user = user
    }
}

class PeopleModel: Decodable {
    var people: [PersonModel]
    
    init () {
        self.people = []
    }
}
