//
//  LoginModel.swift
//  SightSeeStalker
//
//  Created by Danya Polyakov on 15.03.2025.
//

import Foundation

struct LogInDataModel: Encodable {
    var tag: String?
    var password: String?
}

struct LogInResponseModel: Decodable {
    var id: Int
    var accessToken: String
    var refreshToken: String
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case accessToken = "accessToken"
        case refreshToken = "refreshToken"
    }
}
