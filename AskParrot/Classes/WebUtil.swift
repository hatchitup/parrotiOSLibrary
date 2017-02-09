//
//  WebUtil.swift
//  HAIP
//
//  Created by Hemant Singh on 08/12/16.
//  Copyright © 2016 Hemant Singh. All rights reserved.
//

import UIKit
import Alamofire
enum Router: URLRequestConvertible {
    static let baseURLString = "https://askparrot.com"
    static let OAuthToken: String? = AskParrotUI.id
    
    case FAQs()
    
    var method: Alamofire.HTTPMethod {
        switch self {
        case .FAQs:
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .FAQs:
            return "/api/faq"
    
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = URL(string: Router.baseURLString)!
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        urlRequest.httpMethod = method.rawValue
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        if let token = Router.OAuthToken {
            urlRequest.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
            print("Bearer \(token)")
        }
        urlRequest.cachePolicy = .reloadRevalidatingCacheData
        print(urlRequest.url?.absoluteString ?? "nil url")
        switch self {
        case .FAQs:
            return urlRequest
        default:
            return urlRequest
        }
    }
}
