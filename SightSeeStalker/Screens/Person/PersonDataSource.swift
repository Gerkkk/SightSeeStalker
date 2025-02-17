//
//  PersonDataSource.swift
//  SightSeeStalker
//
//  Created by Danya Polyakov on 15.02.2025.
//

import UIKit

extension PersonViewController: UITableViewDataSource {
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
        URL(string: "http://127.0.0.1:8000/user-actions/get-user-posts")
    }
    
    public func getUserPosts() {
        guard let url = getURL() else { return }
        
        let parameters: [String: Any] = [
            "id": personSelected?.id ?? -1
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
                        self?.postsTable.reloadData()
                        self?.viewDidLayoutSubviews()
                        self?.view.setNeedsLayout()
                        self?.view.layoutIfNeeded()
                        
                
                    }
                } catch {
                    print("Error decoding response: \(error)")
                }
            }
        }.resume()

        return
    }
}

extension PersonViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let articleViewController = ArticleViewController(article: Articles[indexPath.row])
        navigationController?.pushViewController(articleViewController, animated: true)
    }
}
