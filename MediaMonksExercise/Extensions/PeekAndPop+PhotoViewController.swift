//
//  PeekAndPop+PhotoViewController.swift
//  MediaMonksExercise
//
//  Created by Ali Murad on 24/08/2018.
//  Copyright © 2018 Media Monks. All rights reserved.
//

import UIKit

typealias PeekAndPopPreview = PhotoViewController
extension PeekAndPopPreview: UIViewControllerPreviewingDelegate {
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, viewControllerForLocation location: CGPoint) -> UIViewController? {
        
        guard let indexPath = self.tableView.indexPathForRow(at: location) else { return nil }
        guard let cell = self.tableView.cellForRow(at: indexPath) else { return nil }
        
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        guard let previewViewController = storyBoard.instantiateViewController(withIdentifier: "PhotoDetailViewController") as? PhotoDetailViewController else { return nil }
        previewViewController.preferredContentSize = CGSize(width: 0.0, height: 550)
        previewViewController.albumID = PhotoViewController.passedValue
        previewViewController.imageID = ids[indexPath.section]
        previewViewController.imgURL = urls[indexPath.section]
        previewViewController.imgTitle = titles[indexPath.section]
        
        
        previewingContext.sourceRect = cell.frame
        return previewViewController
        
    }
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, commit viewControllerToCommit: UIViewController) {
        show(viewControllerToCommit, sender: self)
    }
}
