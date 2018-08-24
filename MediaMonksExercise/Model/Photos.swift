//
//  Photos.swift
//  MediaMonksExercise
//
//  Created by Ali Murad on 24/08/2018.
//  Copyright © 2018 Media Monks. All rights reserved.
//

import Foundation
struct Photos: Codable {
    var id: Int
    var albumId: Int
    var url: String
    var title: String
    var thumbnailUrl: String
}
