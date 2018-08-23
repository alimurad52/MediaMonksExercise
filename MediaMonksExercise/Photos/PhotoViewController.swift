//
//  PhotoViewController.swift
//  MediaMonksExercise
//
//  Created by Ali Murad on 23/08/2018.
//  Copyright © 2018 Media Monks. All rights reserved.
//

import UIKit
import Alamofire

class PhotoViewController: UIViewController {
    
    var passedValue:Int!
    var album_id:[Int] = []
    var ids:[Int] = []
    var titles:[String] = []
    var urls:[String] = []
    var thumnailURL:[String] = []
    let photosURL = "https://jsonplaceholder.typicode.com/photos"
    let globalFunc = GlobalFile()
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        self.view.backgroundColor = UIColor(red:241.0/255.0, green:242.0/255.0, blue:242.0/255.0, alpha:1.0)
        tableView.backgroundColor = .clear
        getData()
        
    }
    func getData() {
        showLoadingOverlay(coveringNavigationBar: true)
        Alamofire.request(photosURL).responseJSON { response in
            let photos = response.result.value as? NSArray
            for i in 0 ..< photos!.count {
                let photos_str = photos?[i] as? Dictionary<String, Any>
                let albumID = photos_str?["albumId"] as? Int
                if albumID == self.passedValue {
                    let id = photos_str?["id"] as? Int
                    self.ids.append(id!)
                    
                    let title = photos_str?["title"] as? String
                    self.titles.append(title!)
                    
                    let url = photos_str?["url"] as? String
                    self.urls.append(url!)
                    
                    let thumbnail_url = photos_str?["thumbnailUrl"] as? String
                    self.thumnailURL.append(thumbnail_url!)
                }
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.hideLoadingOverlay()
                self.globalFunc.animateTable(tableView: self.tableView)
            }
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
        UIView.transition(with: (cell?.imgView)!, duration: 0.2, options: UIViewAnimationOptions.transitionCrossDissolve, animations:  {
            cell?.imgView.downloadImage(from: self.thumnailURL[indexPath.section])
        }, completion: nil)
        return cell!
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let detailVC = storyboard.instantiateViewController(withIdentifier: "PhotoDetailViewController") as? PhotoDetailViewController
        detailVC?.albumID = passedValue
        detailVC?.imageID = ids[indexPath.section]
        detailVC?.imgURL = urls[indexPath.section]
        detailVC?.imgTitle = titles[indexPath.section]
        self.navigationController?.pushViewController(detailVC!, animated: true)
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 8
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        globalFunc.animateTable2(cell: cell)
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }
}
