//
//  PhotoDetailViewController.swift
//  MediaMonksExercise
//
//  Created by Ali Murad on 23/08/2018.
//  Copyright © 2018 Media Monks. All rights reserved.
//

import UIKit

class PhotoDetailViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var lbl_albumID: UILabel!
    @IBOutlet weak var lbl_title: UILabel!
    @IBOutlet weak var img_id: UILabel!
    @IBOutlet weak var imageURL: UILabel!
    
    var imageID:Int!
    var albumID:Int!
    var imgTitle:String?
    var imgURL:String?
    let GlobalFunc = GlobalFile()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        lbl_title.numberOfLines = 0
        imageURL.numberOfLines = 0
        navigationController?.navigationBar.prefersLargeTitles = true
        DispatchQueue.main.async {
            self.showLoadingOverlay(coveringNavigationBar: true)
            self.img_id.attributedText = self.GlobalFunc.attributedText(withString: String(format: "Image ID: %@", "\(self.imageID!)"), boldString: "Image ID", font: self.img_id.font)
            self.lbl_title.attributedText = self.GlobalFunc.attributedText(withString: String(format: "Title: %@", self.imgTitle!), boldString: "Title", font: self.lbl_title.font)
            self.lbl_albumID.attributedText = self.GlobalFunc.attributedText(withString: String(format: "Album ID: %@", "\(self.albumID!)"), boldString: "Album ID", font: self.lbl_albumID.font)
            self.imageURL.attributedText = self.GlobalFunc.attributedText(withString: String(format: "Image URL: %@", self.imgURL!), boldString: "Image URL", font: self.imageURL.font)
            self.getImg()
        }
    }
    func getImg() {
        let session = URLSession(configuration: .default)
        let downloadPicTask = session.dataTask(with: URL(string: imgURL!)!) { (data, response, error) in
            if let e = error {
                print("Error downloading: \(e)")
            } else {
                if let res = response as? HTTPURLResponse {
                    print("Downloaded: \(res.statusCode)")
                    if let imageData = data {
                        let image = UIImage(data: imageData)
                        DispatchQueue.main.async {
                            self.imageView.image = image
                            self.hideLoadingOverlay()
                        }
                    } else {
                        print("cant get image")
                    }
                } else {
                    print("No response")
                }
            }
        }
        downloadPicTask.resume()
    }

}
