//
//  RequestData.swift
//  MediaMonksExercise
//
//  Created by Ali Murad on 24/08/2018.
//  Copyright © 2018 Media Monks. All rights reserved.
//

import Foundation

public struct RequestData {
    public let path: String
    public let method: HTTPMethod
    public let params: [String: Any?]?
    public let headers: [String: String]?
    
    public init (
        path: String,
        method: HTTPMethod = .get,
        params: [String: Any?]? = nil,
        headers: [String: String]? = nil
        ) {
        self.path = path
        self.method = method
        self.params = params
        self.headers = headers
    }
}
