//
//  GlobalFile.swift
//  MediaMonksExercise
//
//  Created by Ali Murad on 23/08/2018.
//  Copyright © 2018 Media Monks. All rights reserved.
//

import UIKit

public class GlobalFile {
    func animateTable(tableView: UITableView) {
        tableView.reloadData()
        let cells = tableView.visibleCells
        let tableHeight: CGFloat = tableView.bounds.size.height
        for i in cells {
            let cell: UITableViewCell = i as UITableViewCell
            cell.transform = CGAffineTransform(translationX: 0, y: tableHeight)
        }
        var index = 0;
        for m in cells {
            let cell: UITableViewCell = m as UITableViewCell
            UIView.animate(withDuration: 3.0, delay: 0.05 * Double(index), usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: [], animations: {
                cell.transform = CGAffineTransform.identity
            }, completion: nil)
            index += 1
        }
    }
    func animateTable2(cell: UITableViewCell) {
        let view = cell.contentView
        let rotationDegrees: CGFloat = -15.0
        let rotationRadians: CGFloat = rotationDegrees * (CGFloat(Double.pi)/180.0)
        let offset = CGPoint(x: -20, y: -20)
        var startTransform = CATransform3DIdentity
        startTransform = CATransform3DRotate(CATransform3DIdentity, rotationRadians, 0.0, 0.0, 1.0)
        startTransform = CATransform3DTranslate(startTransform, offset.x, offset.y, 0.0)
        
        view.layer.transform = startTransform
        view.layer.opacity = 0.8
        
        UIView.animate(withDuration: 0.4) {
            view.layer.transform = CATransform3DIdentity
            view.layer.opacity = 1
        }
    }
}
public extension UIImageView {
    func downloadedFrom(url: URL, contentMode mode: UIViewContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() {
                self.image = image
            }
            }.resume()
    }
    func downloadedFrom(link: String, contentMode mode: UIViewContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloadedFrom(url: url, contentMode: mode)
    }
}
