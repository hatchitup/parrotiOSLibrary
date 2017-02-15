//
//  APSocketManager.swift
//  Pods
//
//  Created by Hemant Singh on 11/02/17.
//
//

import UIKit
import UIKit
import SocketIO
import SwiftSocket

class APSocketManager: NSObject {

    static let sharedInstance = APSocketManager()
    var socket: SocketIOClient! = SocketIOClient(socketURL: NSURL(string: Router.baseURLString )! as URL, config:  [.path("/api/ws"),.log(true), .forcePolling(true),.extraHeaders(["Authorization": ("Bearer " + AskParrot.getToken())])])
    override init() {
        super.init()
        print(AskParrot.getToken())
    }
    
    func establishConnection() {
        if socket != nil && socket.status != .connected {
            socket.connect()
        }
        else{
            socket = SocketIOClient(socketURL: NSURL(string: Router.baseURLString)! as URL, config: [.path("/api/ws"), .log(true), .forcePolling(true),
                    .extraHeaders(["Authorization": ("Bearer " + AskParrot.getToken())])])

            socket.connect()
        }
              }
    func didConnect(socket : SocketIOClient){
        
    }
    func didDisconnect(socket : SocketIOClient){
        
    }
    
    func closeConnection() {
        if socket.status == .connected {
            socket.disconnect()
        }
//
    }
    
    func emitFor(key : String, value: AnyObject)  {
        if socket.status == .connected{
            socket.emit(key, value as! SocketData)
        }
        else if socket.status != .connecting{
            socket.connect()
        }
        
    }
    
    func onData(key : String, completion:@escaping (_ result: [AnyObject]) -> Void) {
        socket.on(key) { ( dataArray, ack) -> Void in
            //            "Session ID unknown" "Authentication error"
            
            if dataArray.count > 0 && dataArray[0] as? String == "Authentication error"{
                self.closeConnection()
                self.socket = nil
            }
            else if dataArray.count > 0 && dataArray[0] as? String == "Session ID unknown" {
               
            }
            else if dataArray.count > 0 && (dataArray[0] as? String)?.characters.first == "<" {
            
            }
            else if dataArray.count > 0 && dataArray[0] as? String == "server error" {
                
            }
            else{
                completion(dataArray as [AnyObject])
            }
            
            
        }
    }

}
