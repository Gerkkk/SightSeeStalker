//
//  Article.swift
//  SightSeeStalker
//
//  Created by Danya Polyakov on 21.01.2025.
//

import UIKit

class ArticleModel: Decodable {
    var authorID: Int?
    var authorName: String?
    var authorTag: String?
    var authorAvatar: String?
    
    var title: String?
    var date: Date?
    var coordsN: Double?
    var coordsW: Double?
    var brief: String?
    var text: String?
    var images: [String]?
    
    enum CodingKeys: String, CodingKey {
        case authorID = "author_id"
        case authorName = "author_name"
        case authorTag = "author_tag"
        case authorAvatar = "author_avatar"
        case title = "title"
        case date = "date"
        case coordsN = "coords_n"
        case coordsW = "coords_w"
        case brief = "brief"
        case text = "text"
        case images = "images"
    }
    
    init(authorID: Int? = nil, authorName: String? = nil, authorTag: String? = nil, authorAvatar: String? = nil, title: String? = nil, date: Double? = nil, coordsN: Double? = nil, coordsW: Double? = nil, brief: String? = nil, text: String? = nil, images: [String]? = nil) {
        self.authorID = authorID
        self.authorName = authorName
        self.authorTag = authorTag
        self.authorAvatar = authorAvatar
        self.title = title
        self.date = Date(timeIntervalSince1970: date!)
        self.coordsN = coordsN
        self.coordsW = coordsW
        self.brief = brief
        self.text = text
        self.images = images
    }
}

class ArticlesModel: Decodable {
    var articles: [ArticleModel]
    
    init (articles: [ArticleModel] = []) {
        self.articles = articles
    }
}
