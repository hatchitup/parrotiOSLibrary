

import Foundation
import UIKit
import Alamofire
import SwiftyJSON

class Conversation {
//MARK: Properties
let user: User
var ticket: String
var lastMessage: Message

//MARK: Methods
class func showConversations(completion: @escaping ([Conversation]) -> Swift.Void) {
    var conversations = [Conversation]()
    Alamofire.request(Router.GetTickets()).responseJSON { (response) in
        switch response.result {
        case .success(let value):
            let json = JSON(value)
            print("JSON: \(json)")
            if json["data"].arrayValue.count > 0 {
                for conv in json["data"].arrayValue {
                    User.info(forUserID: conv["companyId"].stringValue, completion: { (user) in
                        let emptyMessage = Message.init(type: .text, content: "loading", owner: .sender, timestamp: 0, isRead: true)
                        let conversation = Conversation.init(user: user, lastMessage: emptyMessage, ticket: conv["id"].stringValue)
                        conversations.append(conversation)
                        conversation.lastMessage.downloadLastMessage(msg: conv["conversation"],fromConv: true, completion: { (_) in
                            completion(conversations)
                        })
                    })
                }
            }
        case .failure(let error):
            print(error)
        }
    }
    }
//MARK: Inits
    init(user: User, lastMessage: Message, ticket: String) {
    self.user = user
    self.lastMessage = lastMessage
    self.ticket = ticket
}
}
