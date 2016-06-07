//
//  RestApiManager.swift
//  recipev2
//
//  Created by Reinaldo B Camargo on 6/7/16.
//  Copyright © 2016 Reinaldo B Camargo. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire

typealias ServiceResponse = (JSON, NSError?) -> Void

class RestApiManager: NSObject {
    
    let baseURL = "http://webapireceitas.azurewebsites.net/api/"
    
    func makeHTTPGetRequest(endPointUrl: String, onCompletion: ServiceResponse) {
        let path = baseURL + endPointUrl
        Alamofire.request(.GET, path)
                .validate(statusCode: 200..<300)
                .validate(contentType: ["application/json"])
                .responseJSON { response in
                    switch response.result {
                    case .Success:
                        let json:JSON = JSON(response.result.value!)
                        onCompletion(json, nil)
                    case .Failure(let error):
                        onCompletion(nil, error)
                    }
                }
    }
    
    //body.object as! [String : AnyObject]
    func makeHTTPPostRequest(endPointUrl: String, body: JSON, onCompletion: ServiceResponse) {
        let path = baseURL + endPointUrl
        Alamofire.request(.POST, path, parameters: body.dictionaryObject, encoding: .JSON)
            .responseJSON { response in
                guard response.result.error == nil else {
                    // got an error in getting the data, need to handle it
                    onCompletion(nil, response.result.error!)
                    return
                }
                
                guard let value = response.result.value else {
                    //como instanciar um erro do NSError com essa mensagem
                    print("no result data received when calling GET on /todos/1")
                    onCompletion(nil, response.result.error!)
                    return
                }
                
                let json:JSON = JSON(value)
                onCompletion(json, nil)
            }
    }
}

