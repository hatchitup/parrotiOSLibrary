//
//  WebUtil.swift
//  AskParrot
//
//  Created by Hemant Singh on 08/12/16.
//  Copyright © 2016 Hemant Singh. All rights reserved.
//

import UIKit
import Alamofire
enum Router: URLRequestConvertible {
    static let baseURLString = "https://askparrot.com"
    
    case Register([String: AnyObject])
    case FAQs()
    case Ping()
    case AddTicket([String: AnyObject])
    case GetTickets()
    case GetUser([String: AnyObject])
    case GetMessages(String)
    var method: Alamofire.HTTPMethod {
        switch self {
        case .Register:
            return .post
        case .Ping:
            return .get
        case .FAQs:
            return .get
        case .AddTicket:
            return .post
        case .GetTickets:
            return .get
        case .GetUser:
            return .get
        case .GetMessages:
            return .get
        }
    }
    var token: String {
        switch self {
        case .Register:
            return AskParrotUI.config.appID
        case .FAQs:
            return AskParrotUI.config.appID
        default:
            return AskParrotUI.getToken()
        }
    }
    var path: String {
        switch self {
        case .Register:
            return "/api/customer"
        case .FAQs:
            return "/api/faq"
        case .Ping:
            return "/api/pingcustomer"
        case .AddTicket:
            return "/api/ticket"
        case .GetTickets:
            return "/api/tickets"
        case .GetUser:
            return "/api/userinfo"
        case .GetMessages(let id):
            return "api/tickets/\(id)/conversation"
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = URL(string: Router.baseURLString)!
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        urlRequest.httpMethod = method.rawValue
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.setValue("Bearer " + token, forHTTPHeaderField: "Authorization")
        urlRequest.cachePolicy = .reloadRevalidatingCacheData
        print(urlRequest.url?.absoluteString ?? "nil url")
        switch self {
        case .Register(let params):
            return try Alamofire.JSONEncoding.default.encode(urlRequest, with: params)
        case .AddTicket(let params):
            return try Alamofire.JSONEncoding.default.encode(urlRequest, with: params)
        case .GetUser(let params):
            return try Alamofire.URLEncoding.queryString.encode(urlRequest, with: params)
        default:
            return urlRequest
        }
    }
}
