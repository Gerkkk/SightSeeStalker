//
//  ExploreInteractorMock.swift
//  SightSeeStalkerTests
//
//  Created by Danya Polyakov on 15.03.2025.
//

import Foundation
import SightSeeStalker
import UIKit

final class ExploreWorkerMock: ExploreWorkerProtocol {
    func fetchSearchResults(query: String, searchType: Int, completion: @escaping (Result<SightSeeStalker.ExploreDataModel, any Error>) -> Void) {
        
        if searchType == 0 {
            let mockData = ExploreDataModel(people: [PersonModel(id: 9, name: "Ivan", tag: "vanya", status: "", follows: nil, followersNum: 10, avatar: nil)], articles: nil)
            completion(.success(mockData))
        } else {
            let mockData = ExploreDataModel(people: nil, articles: [ArticleModel(authorID: 1, authorName: "a", authorTag: "b", authorAvatar: nil, title: "c", date: nil, coordsN: nil, coordsW: nil, brief: "d", text: "e", images: nil)])
            completion(.success(mockData))
        }
    }
    
    
}
