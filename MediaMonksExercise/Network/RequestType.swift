//
//  RequestType.swift
//  MediaMonksExercise
//
//  Created by Ali Murad on 24/08/2018.
//  Copyright © 2018 Media Monks. All rights reserved.
//

import Foundation

public protocol RequestType {
    associatedtype ResponseType: Codable
    var data: RequestData { get }
}
public extension RequestType {
    
    public func execute (
        dispatcher: NetworkDispatcher = URLSessionNetworkDispatcher.instance,
        onSuccess: @escaping (ResponseType) -> Void,
        onError: @escaping (Error) -> Void
        ) {
        dispatcher.dispatch(
            request: self.data,
            onSuccess: { (responseData: Data) in
                do {
                    let jsonDecoder = JSONDecoder()
                    let result = try jsonDecoder.decode(ResponseType.self, from: responseData)
                    DispatchQueue.main.async {
                        onSuccess(result)
                    }
                } catch let error {
                    DispatchQueue.main.async {
                        onError(error)
                    }
                }
        },
            onError: { (error: Error) in
                DispatchQueue.main.async {
                    onError(error)
                }
        }
        )
    }
}
