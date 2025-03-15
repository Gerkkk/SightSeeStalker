//
//  NewsTableViewDataSource.swift
//  SightSeeStalker
//
//  Created by Danya Polyakov on 14.03.2025.
//

import Foundation
import UIKit

// MARK: - UITableViewDataSource
extension NewsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ArticleCell.reuseId, for: indexPath)
        guard let articleCell = cell as? ArticleCell else { return cell }
        articleCell.configure(with: Articles[indexPath.row])
        return articleCell
    }
}
