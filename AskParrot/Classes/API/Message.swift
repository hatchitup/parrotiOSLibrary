


import Foundation
import UIKit
import Alamofire
import SwiftyJSON

class Message {
    
    //MARK: Properties
    var owner: MessageOwner
    var type: MessageType
    var content: Any
    var timestamp: Int
    var isRead: Bool
    var image: UIImage?
    private var toID: String?
    private var fromID: String?
    
    //MARK: Methods
    class func downloadAllMessages(forTicketID: String, completion: @escaping (Message) -> Swift.Void) {
           Alamofire.request(Router.GetMessages(forTicketID)).responseJSON(completionHandler: { (response) in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print("JSON: \(json)")
                for msg in json["data"].arrayValue {
                let message = Message.init(type: .text, content: "loading", owner: .sender, timestamp: 0, isRead: true)
                    message.downloadLastMessage(msg: msg,fromConv: false, completion: { (_) in
                        completion(message)
                    })
                }
            case .failure(let error):
                print(error)
            }
           })
//        chat
        APSocketManager.sharedInstance.onData(key: "chat") { (response) in
            print(JSON(response))
            if JSON(response)["message"] != nil {
            let message = Message.init(type: .text, content: "loading", owner: .sender, timestamp: 0, isRead: true)
            print(JSON(response))
            message.downloadLastMessage(msg: JSON(response),fromConv: true, completion: { (_) in
                completion(message)
            })
            }
        }
        APSocketManager.sharedInstance.onData(key: forTicketID) { (response) in
            print(JSON(response.first))
            if JSON(response.first)["message"] != nil {
            let message = Message.init(type: .text, content: "loading", owner: .sender, timestamp: 0, isRead: true)
            print(JSON(response))
            message.downloadLastMessage(msg: JSON(response.first),fromConv: true, completion: { (_) in
                completion(message)
            })
            }
        }
//            FIRDatabase.database().reference().child("users").child(currentUserID).child("conversations").child(forUserID).observe(.value, with: { (snapshot) in
//                if snapshot.exists() {
//                    let data = snapshot.value as! [String: String]
//                    let location = data["location"]!
//                    FIRDatabase.database().reference().child("conversations").child(location).observe(.childAdded, with: { (snap) in
//                        if snap.exists() {
//                            let receivedMessage = snap.value as! [String: Any]
//                            let messageType = receivedMessage["type"] as! String
//                            var type = MessageType.text
//                            switch messageType {
//                                case "photo":
//                                type = .photo
//                                case "location":
//                                type = .location
//                            default: break
//                            }
//                            let content = receivedMessage["content"] as! String
//                            let fromID = receivedMessage["fromID"] as! String
//                            let timestamp = receivedMessage["timestamp"] as! Int
//                            if fromID == currentUserID {
//                                let message = Message.init(type: type, content: content, owner: .receiver, timestamp: timestamp, isRead: true)
//                                completion(message)
//                            } else {
//                                let message = Message.init(type: type, content: content, owner: .sender, timestamp: timestamp, isRead: true)
//                                completion(message)
//                            }
//                        }
//                    })
//                }
//            })
//        }
    }
    
    func downloadImage(indexpathRow: Int, completion: @escaping (Bool, Int) -> Swift.Void)  {
//        if self.type == .photo {
//            let imageLink = self.content as! String
//            let imageURL = URL.init(string: imageLink)
//            URLSession.shared.dataTask(with: imageURL!, completionHandler: { (data, response, error) in
//                if error == nil {
//                    self.image = UIImage.init(data: data!)
//                    completion(true, indexpathRow)
//                }
//            }).resume()
//        }
    }
    
    class func markMessagesRead(forUserID: String)  {
//        if let currentUserID = FIRAuth.auth()?.currentUser?.uid {
//            FIRDatabase.database().reference().child("users").child(currentUserID).child("conversations").child(forUserID).observeSingleEvent(of: .value, with: { (snapshot) in
//                if snapshot.exists() {
//                    let data = snapshot.value as! [String: String]
//                    let location = data["location"]!
//                    FIRDatabase.database().reference().child("conversations").child(location).observeSingleEvent(of: .value, with: { (snap) in
//                        if snap.exists() {
//                            for item in snap.children {
//                                let receivedMessage = (item as! FIRDataSnapshot).value as! [String: Any]
//                                let fromID = receivedMessage["fromID"] as! String
//                                if fromID != currentUserID {
//                                    FIRDatabase.database().reference().child("conversations").child(location).child((item as! FIRDataSnapshot).key).child("isRead").setValue(true)
//                                }
//                            }
//                        }
//                    })
//                }
//            })
//        }
    }
   
    func downloadLastMessage(msg: JSON,fromConv: Bool, completion: @escaping (Void) -> Swift.Void) {
        if let currentUserID = PersistencyManager.getUser().id {
                if msg != nil && msg["message"] != nil {
                        let receivedMessage = msg
                        self.content = receivedMessage["message"].stringValue
                        self.timestamp = receivedMessage["timestamp"].intValue
                        let messageType = receivedMessage["type"].stringValue
                        let fromID = fromConv ? receivedMessage["from"].stringValue : receivedMessage["from"]["id"].stringValue
                        self.isRead = receivedMessage["status"].boolValue
                        var type = MessageType.text
                        switch messageType {
                        case "text":
                            type = .text
                        case "photo":
                            type = .photo
                        case "location":
                            type = .location
                        default: break
                        }
                        self.type = type
                        if currentUserID == fromID {
                            self.owner = .receiver
                        } else {
                            self.owner = .sender
                        }
                        completion()
                }
            
        }
    }

    class func send(message: Message, toID: String, completion: @escaping (Bool) -> Swift.Void)  {
            let values = ["type": "text", "message": message.content, "ticketId": toID]
                            Message.uploadMessage(withValues: values, toID: toID, completion: { (status) in
                                completion(status)
                            })

        
//            switch message.type {
//            case .location:
//                let values = ["type": "location", "content": message.content, "fromID": currentUserID, "toID": toID, "timestamp": message.timestamp, "isRead": false]
//                Message.uploadMessage(withValues: values, toID: toID, completion: { (status) in
//                    completion(status)
//                })
//            case .photo:
//                let imageData = UIImageJPEGRepresentation((message.content as! UIImage), 0.5)
//                let child = UUID().uuidString
//                FIRStorage.storage().reference().child("messagePics").child(child).put(imageData!, metadata: nil, completion: { (metadata, error) in
//                    if error == nil {
//                        let path = metadata?.downloadURL()?.absoluteString
//                        let values = ["type": "photo", "content": path!, "fromID": currentUserID, "toID": toID, "timestamp": message.timestamp, "isRead": false] as [String : Any]
//                        Message.uploadMessage(withValues: values, toID: toID, completion: { (status) in
//                            completion(status)
//                        })
//                    }
//                })
//            case .text:
//                let values = ["type": "text", "content": message.content, "fromID": currentUserID, "toID": toID, "timestamp": message.timestamp, "isRead": false]
//                Message.uploadMessage(withValues: values, toID: toID, completion: { (status) in
//                    completion(status)
//                })
//            }
//        }
    }
    
    class func uploadMessage(withValues: [String: Any], toID: String, completion: @escaping (Bool) -> Swift.Void) {
                APSocketManager.sharedInstance.emitFor(key: "chat", value: withValues as AnyObject)
    }
    
    //MARK: Inits
    init(type: MessageType, content: Any, owner: MessageOwner, timestamp: Int, isRead: Bool) {
        self.type = type
        self.content = content
        self.owner = owner
        self.timestamp = timestamp
        self.isRead = isRead
    }
}
