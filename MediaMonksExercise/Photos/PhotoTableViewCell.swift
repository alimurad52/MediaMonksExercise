//
//  PhotoTableViewCell.swift
//  MediaMonksExercise
//
//  Created by Ali Murad on 23/08/2018.
//  Copyright © 2018 Media Monks. All rights reserved.
//

import UIKit

class PhotoTableViewCell: UITableViewCell {

    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var lbl_img: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        lbl_img.numberOfLines = 0
        lbl_img.font = lbl_img.font.withSize(16)
        imgView.layer.borderWidth = 0
        imgView.layer.cornerRadius = imgView.frame.height/2
        imgView.clipsToBounds = true
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
