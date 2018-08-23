//
//  AlbumViewController.swift
//  MediaMonksExercise
//
//  Created by Ali Murad on 23/08/2018.
//  Copyright © 2018 Media Monks. All rights reserved.
//

import UIKit
import Alamofire

class AlbumViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    var album_ids:[Int] = []
    var userIds:[Int] = []
    var titles:[String] = []
    let albumURL = "https://jsonplaceholder.typicode.com/albums"
    let globalFunc = GlobalFile()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        getData()
        
    }
    func getData() {
        showLoadingOverlay(coveringNavigationBar: true)
        Alamofire.request(albumURL).responseJSON { response in
            let albums = response.result.value as? NSArray
            for i in 0 ..< albums!.count {
                let album_str = albums?[i] as? Dictionary<String, Any>
                
                let id = album_str?["id"] as? Int
                self.album_ids.append(id!)
                
                let userId = album_str?["userId"] as? Int
                self.userIds.append(userId!)
                
                let albumTitle = album_str?["title"] as? String
                self.titles.append(albumTitle!)
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.hideLoadingOverlay()
                self.globalFunc.animateTable(tableView: self.tableView)
            }
        }
    }
}
extension AlbumViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return album_ids.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AlbumTableViewCell") as? AlbumTableViewCell
        cell?.lbl_album_title.text = titles[indexPath.row]
        return cell!
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let valueToPass = self.album_ids[indexPath.row]
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let photoVC = storyboard.instantiateViewController(withIdentifier: "PhotoViewController") as? PhotoViewController
        photoVC?.passedValue = valueToPass
        self.navigationController?.pushViewController(photoVC!, animated: true)
    }
}
