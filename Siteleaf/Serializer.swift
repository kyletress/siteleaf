//
//  Serializer.swift
//  Siteleaf
//
//  Created by Kyle Tress on 10/18/15.
//  Copyright © 2015 Kyle Tress. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

// Single object
public protocol ResponseObjectSerializable {
  init?(response: NSHTTPURLResponse, representation: AnyObject)
  // init?(json: SwiftyJSON.json)
}

// collection of objects
public protocol ResponseCollectionSerializable {
  static func collection(response response: NSHTTPURLResponse, representation: AnyObject) -> [Self]
}

extension Request {
  public func responseObject<T: ResponseObjectSerializable>(completionHandler: Response<T, NSError> -> Void) -> Self {
    let responseSerializer = ResponseSerializer<T, NSError> { request, response, data, error in
      guard error == nil else { return .Failure(error!) }
      
      let JSONResponseSerializer = Request.JSONResponseSerializer(options: .AllowFragments)
      let result = JSONResponseSerializer.serializeResponse(request, response, data, error)
      
      switch result {
      case .Success(let value):
        if let
          response = response,
          responseObject = T(response: response, representation: value)
        {
          return .Success(responseObject)
        } else {
          let failureReason = "JSON could not be serialized into response object: \(value)"
          let error = Error.errorWithCode(.JSONSerializationFailed, failureReason: failureReason)
          return .Failure(error)
        }
      case .Failure(let error):
        return .Failure(error)
      }
    }
    
    return response(responseSerializer: responseSerializer, completionHandler: completionHandler)
  }
  
  public func responseCollection<T: ResponseCollectionSerializable>(completionHandler: Response<[T], NSError> -> Void) -> Self {
    let responseSerializer = ResponseSerializer<[T], NSError> { request, response, data, error in
      guard error == nil else { return .Failure(error!) }
      
      let JSONSerializer = Request.JSONResponseSerializer(options: .AllowFragments)
      let result = JSONSerializer.serializeResponse(request, response, data, error)
      
      switch result {
      case .Success(let value):
        if let response = response {
          return .Success(T.collection(response: response, representation: value))
        } else {
          let failureReason = "Response collection could not be serialized due to nil response"
          let error = Error.errorWithCode(.JSONSerializationFailed, failureReason: failureReason)
          return .Failure(error)
        }
      case .Failure(let error):
        return .Failure(error)
      }
    }
    
    return response(responseSerializer: responseSerializer, completionHandler: completionHandler)
  }
}



