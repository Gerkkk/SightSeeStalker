//
//  NewsDataSource.swift
//  SightSeeStalker
//
//  Created by Danya Polyakov on 09.02.2025.
//

import Foundation
import UIKit
import Darwin

// MARK: - UITableViewDataSource
extension NewsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Articles.count
    }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: ArticleCell.reuseId,
            for: indexPath
        )
        guard let articleCell = cell as? ArticleCell else { return cell }
        articleCell.configure(with: Articles[indexPath.row])
        return articleCell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    private func getURL() -> URL? {
        URL(string: "http://127.0.0.1:8000/user-actions/fetch-news")
    }
    
    internal func fetchNews() {
        guard let url = getURL() else { return }
        
        let parameters: [String: Any] = [
            "user_id": 0, //TODO: Fix user_id
            "page_size": 10,
            "page_num": 0
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
                    var articlesPage: ArticlesModel?

                    articlesPage = try decoder.decode(ArticlesModel.self, from: data)
                    DispatchQueue.main.async {
                        self?.Articles = articlesPage?.articles ?? []
                        self?.newsTable.reloadData()
                    }
                } catch {
                    print("Error decoding response: \(error)")
                }
            }
        }.resume()

        return
    }
}

extension NewsViewController: UITableViewDelegate {
//    private func handleMarkAsFavourite() {
//        print("Marked as favourite")
//    }
//
//    func tableView(_ tableView: UITableView,
//                   leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
//        let action = UIContextualAction(style: .normal,
//                                        title: "Share via VK") { [weak self] (action, view, completionHandler) in
//                                            self?.handleMarkAsFavourite()
//                                            completionHandler(true)
//        }
//
//        return UISwipeActionsConfiguration(actions: [action])
//    }
}

