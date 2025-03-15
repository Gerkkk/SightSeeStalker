//
//  TableViewDelegate.swift
//  SightSeeStalker
//
//  Created by Danya Polyakov on 15.03.2025.
//

import Foundation
import UIKit

extension PersonViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        router.navigateToArticle(article: articles[indexPath.row])
    }
}
