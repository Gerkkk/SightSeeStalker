//
//  ExploreDataModel.swift
//  SightSeeStalker
//
//  Created by Danya Polyakov on 02.03.2025.
//

import Foundation

public struct ExploreDataModel: Decodable {
    public var people: [PersonModel]?
    public var articles: [ArticleModel]?
    
    public init(people: [PersonModel]?, articles: [ArticleModel]?) {
        self.people = people
        self.articles = articles
    }
}
