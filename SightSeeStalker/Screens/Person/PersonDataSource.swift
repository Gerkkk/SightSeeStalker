//
//  PersonDataSource.swift
//  SightSeeStalker
//
//  Created by Danya Polyakov on 15.03.2025.
//

import Foundation
import UIKit

extension PersonViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ArticleCell.reuseId, for: indexPath)
        guard let articleCell = cell as? ArticleCell else { return cell }
        articleCell.configure(with: articles[indexPath.row])
        return articleCell
    }
}

