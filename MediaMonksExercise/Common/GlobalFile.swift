//
//  GlobalFile.swift
//  MediaMonksExercise
//
//  Created by Ali Murad on 23/08/2018.
//  Copyright © 2018 Media Monks. All rights reserved.
//

import UIKit
struct GlobalVariables {
    static var baseURL = "https://jsonplaceholder.typicode.com/albums"
}
class GlobalFile {
    func attributedText(withString string: String, boldString: String, font: UIFont) -> NSAttributedString {
        let attributedString = NSMutableAttributedString(string: string,
                                                         attributes: [NSAttributedStringKey.font: font])
        let boldFontAttribute: [NSAttributedStringKey: Any] = [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: font.pointSize)]
        let range = (string as NSString).range(of: boldString)
        attributedString.addAttributes(boldFontAttribute, range: range)
        return attributedString
    }
}
