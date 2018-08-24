//
//  PhotoViewController.swift
//  MediaMonksExercise
//
//  Created by Ali Murad on 23/08/2018.
//  Copyright © 2018 Media Monks. All rights reserved.
//

import UIKit

class PhotoViewController: UIViewController {
    
    static var passedValue:Int!
    var album_id:[Int] = []
    var ids:[Int] = []
    var titles:[String] = []
    var urls:[String] = []
    var thumnailURL:[String] = []
    let animation = Animation()
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        self.view.backgroundColor = UIColor(red:241.0/255.0, green:242.0/255.0, blue:242.0/255.0, alpha:1.0)
        navigationController?.navigationBar.prefersLargeTitles = true
        tableView.backgroundColor = .clear
        if traitCollection.forceTouchCapability == UIForceTouchCapability.available {
            registerForPreviewing(with: self, sourceView: self.tableView)
        } else {
        }
        print(PhotoViewController.passedValue!)
        showLoadingOverlay(coveringNavigationBar: true)
        GetData().execute(onSuccess: {(photos: [Photos]) in
            print(photos.albumId)
            self.album_id = photos.albumId
            self.ids = photos.id
            self.titles = photos.title
            self.urls = photos.url
            self.thumnailURL = photos.thumbnailUrl
            self.tableView.reloadData()
            self.hideLoadingOverlay()
            self.animation.animateTable(tableView: self.tableView)
        }, onError: {(error: Error) in
            
        })
    }
    struct GetData: RequestType {
        weak var pv: PhotoViewController!
        typealias ResponseType = [Photos]
        var data: RequestData {
            return RequestData(path: GlobalVariables.baseURL + "/\(PhotoViewController.passedValue!)/photos")
        }
    }
}
extension PhotoViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return ids.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PhotoTableViewCell") as? PhotoTableViewCell
        cell?.lbl_img.text = titles[indexPath.section]
        cell?.layer.cornerRadius = 10
        cell?.layer.masksToBounds = true
        UIView.transition(with: (cell?.imgView)!, duration: 0.2, options: UIViewAnimationOptions.transitionCrossDissolve, animations:  {
            cell?.imgView.downloadImage(from: self.thumnailURL[indexPath.section])
        }, completion: nil)
        return cell!
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let detailVC = storyboard.instantiateViewController(withIdentifier: "PhotoDetailViewController") as? PhotoDetailViewController
        detailVC?.albumID = PhotoViewController.passedValue
        detailVC?.imageID = ids[indexPath.section]
        detailVC?.imgURL = urls[indexPath.section]
        detailVC?.imgTitle = titles[indexPath.section]
        self.navigationController?.pushViewController(detailVC!, animated: true)
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 8
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }
}
extension Array where Element == Photos {
    var albumId: [Int] {
        return map { $0.albumId }
    }
    var id: [Int] {
        return map { $0.id }
    }
    var title: [String] {
        return map { $0.title }
    }
    var url: [String] {
        return map { $0.url }
    }
    var thumbnailUrl: [String] {
        return map { $0.thumbnailUrl }
    }
}
