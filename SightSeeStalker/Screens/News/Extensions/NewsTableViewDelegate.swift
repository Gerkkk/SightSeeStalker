//
//  NewsTableViewDelegate.swift
//  SightSeeStalker
//
//  Created by Danya Polyakov on 14.03.2025.
//

import Foundation
import UIKit

// MARK: - UITableViewDelegate
extension NewsViewController: UITableViewDelegate {
    private enum Constants {
        static let newsFetchDelta = CGFloat(100)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        presenter?.didSelectArticle(Articles[indexPath.row])
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let contentHeight = scrollView.contentSize.height
        let scrollPosition = scrollView.contentOffset.y
        let tableViewHeight = scrollView.frame.size.height
        
        if scrollPosition + tableViewHeight > contentHeight - Constants.newsFetchDelta {
            presenter?.fetchNews()
        }
    }
}
