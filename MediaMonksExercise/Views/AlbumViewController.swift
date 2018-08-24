//
//  AlbumViewController.swift
//  MediaMonksExercise
//
//  Created by Ali Murad on 23/08/2018.
//  Copyright © 2018 Media Monks. All rights reserved.
//

import UIKit
import RevealingSplashView

class AlbumViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    var album_ids:[Int] = []
    var userIds:[Int] = []
    var titles:[String] = []
    let animation = Animation()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let revealingSplashView = RevealingSplashView(iconImage: UIImage(named: "Logo")!, iconInitialSize: CGSize(width: 100, height: 70), backgroundColor: UIColor.black)
        revealingSplashView.useCustomIconColor = true
        navigationController?.navigationBar.prefersLargeTitles = true
        revealingSplashView.iconColor = UIColor.white
        let window = UIApplication.shared.keyWindow
        window?.addSubview(revealingSplashView)
        revealingSplashView.startAnimation()
        
        
        tableView.delegate = self
        tableView.dataSource = self
        self.view.backgroundColor = UIColor(red:241.0/255.0, green:242.0/255.0, blue:242.0/255.0, alpha:1.0)
        tableView.backgroundColor = .clear
        
        GetData().execute(onSuccess: {(albums: [Albums])in
            self.album_ids = albums.id
            self.userIds = albums.userId
            self.titles = albums.title
            self.tableView.reloadData()
            self.animation.animateTable(tableView: self.tableView)
        }, onError: {(error: Error)in
        })
    }
    struct GetData: RequestType {
        typealias ResponseType = [Albums]
        var data: RequestData {
            return RequestData(path: GlobalVariables.baseURL)
        }
    }
}
extension AlbumViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return album_ids.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AlbumTableViewCell") as? AlbumTableViewCell
        cell?.layer.cornerRadius = 10
        cell?.layer.masksToBounds = true
        cell?.lbl_album_title.text = titles[indexPath.section]
        return cell!
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let valueToPass = self.album_ids[indexPath.section]
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let photoVC = storyboard.instantiateViewController(withIdentifier: "PhotoViewController") as? PhotoViewController
        PhotoViewController.passedValue = valueToPass
        self.navigationController?.pushViewController(photoVC!, animated: true)
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
extension Array where Element == Albums {
    var userId: [Int] {
        return map { $0.userId }
    }
    var id: [Int] {
        return map { $0.id }
    }
    var title: [String] {
        return map { $0.title }
    }
}
