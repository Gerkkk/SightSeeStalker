//
//  ExploreInteractorTests.swift
//  SightSeeStalkerTests
//
//  Created by Danya Polyakov on 15.03.2025.
//

import XCTest
import SightSeeStalker

final class ExploreInteractorTests: XCTestCase {
    var worker = ExploreWorkerMock()
    var interactor: ExploreInteractorProtocol?

    override func setUpWithError() throws {
        try super.setUpWithError()
        interactor = ExploreInteractor(worker: worker)
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
        interactor = nil
    }

    func testPeople() throws {
        var mockData: ExploreDataModel?
        
        worker.fetchSearchResults(query: "", searchType: 0) { result in
            switch result {
            case .success(let data):
                mockData = data
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
            }
        }
        
        XCTAssertEqual(mockData?.people?.count, 1)
    }
    
    func testArticles() throws {
        var mockData: ExploreDataModel?
        
        worker.fetchSearchResults(query: "search", searchType: 1) { result in
            switch result {
            case .success(let data):
                mockData = data
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
            }
        }
        
        XCTAssertEqual(mockData?.articles?.count, 1)
    }

    func testPerformanceExample() throws {
        
        measure {
            var mockData: ExploreDataModel?
            worker.fetchSearchResults(query: "", searchType: 0) { result in
                switch result {
                case .success(let data):
                    mockData = data
                case .failure(let error):
                    print("Error: \(error.localizedDescription)")
                }
            }
        }
    }

}

