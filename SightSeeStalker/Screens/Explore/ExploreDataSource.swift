//
//  PersonDataSource.swift
//  SightSeeStalker
//
//  Created by Danya Polyakov on 21.01.2025.
//

import Foundation
import UIKit
import Darwin

// MARK: - UITableViewDataSource
extension ExploreViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if buttonsToggle.isLeftButtonSelected {
            table.rowHeight = 81
            return People.count
        } else {
            table.rowHeight = 430
            return Articles.count
        }
    }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(
//            withIdentifier: PersonCell.reuseId,
//            for: indexPath
//        )
//        guard let personCell = cell as? PersonCell else { return cell }
//        personCell.configure(with: People[indexPath.row])
//        return personCell
        if buttonsToggle.isLeftButtonSelected {
            let cell = tableView.dequeueReusableCell(
                withIdentifier: PersonCell.reuseId,
                for: indexPath
            )
            guard let personCell = cell as? PersonCell else { return cell }
            personCell.configure(with: People[indexPath.row])
            return personCell
        } else {
            let cell = tableView.dequeueReusableCell(
                withIdentifier: ArticleCell.reuseId,
                for: indexPath
            )
            guard let articleCell = cell as? ArticleCell else { return cell }
            articleCell.configure(with: Articles[indexPath.row])
            return articleCell
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
//        if buttonsToggle.isLeftButtonSelected {
//            return People.count
//        } else {
//            return Articles.count
//        }
        return 1
    }
    
    private func getURL() -> URL? {
        URL(string: "http://127.0.0.1:8000/user-actions/fetch-search-results")
    }
    
    internal func searchWithParams() {
        guard let url = getURL() else { return }
        
        let parameters: [String: Any] = [
            "user_id": 0, //TODO: Fix user_id
            "search_field_string": textField.text ?? "",
            "searching_type": buttonsToggle.isLeftButtonSelected ? 0: 1
        ]
        
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: []) else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = httpBody
        
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            if let error = error {
                print("Error: \(error)")
                return
            }
            
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    
                    var peoplePage: PeopleModel?
                    var articlesPage: ArticlesModel?
                    
                    if self?.buttonsToggle.isLeftButtonSelected == true {
                        peoplePage = try decoder.decode(PeopleModel.self, from: data)
                        DispatchQueue.main.async {
                            self?.People = peoplePage?.people ?? []
                            self?.Articles = []
                            self?.table.reloadData()
                        }
                    } else {
                        articlesPage = try decoder.decode(ArticlesModel.self, from: data)
                        DispatchQueue.main.async {
                            self?.Articles = articlesPage?.articles ?? []
                            self?.People = []
                            self?.table.reloadData()
                        }
                    }
                } catch {
                    print("Error decoding response: \(error)")
                }
            }
        }.resume()
        //sleep(1)
        return
    }
    
//    internal func fetchPeople() -> [PersonModel]{
//        //TODO: Add error catching
//
//        guard let url = getURL() else { return [] }
//        var newsPageParsed: PeopleModel = PeopleModel()
//        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
//            if let error = error {
//                print(error)
//                return
//            }
//            
//            if
//                let self,
//                let data = data,
//                let newsPage = try? decoder.decode(PeopleModel.self, from: data)
//            {
//                newsPageParsed = newsPage
//                //newsPageParsed.passTheRequestId()
//                print(newsPageParsed)
//                
//            }
//        }.resume()
//        //bad. fix
//        sleep(1)
//        return newsPageParsed.people
//    }

}

extension ExploreViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if buttonsToggle.isLeftButtonSelected {
            let personViewController = PersonViewController(person: People[indexPath.row])
            personViewController.personSelected = People[indexPath.row]
            
            navigationController?.pushViewController(personViewController, animated: true)
        } else {
            let articleViewController = ArticleViewController(article: Articles[indexPath.row])

            
            navigationController?.pushViewController(articleViewController, animated: true)
        }
    }
}
