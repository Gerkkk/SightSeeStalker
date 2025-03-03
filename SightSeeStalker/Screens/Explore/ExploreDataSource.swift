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
        return 1
    }
}

extension ExploreViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if buttonsToggle.isLeftButtonSelected {
            self.presenter?.personSelected(person: People[indexPath.row])
        } else {
            self.presenter?.articleSelected(article: Articles[indexPath.row])
        }
    }
}
