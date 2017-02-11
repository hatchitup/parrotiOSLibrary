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
    var key = ""
    var value = ""
    var socket: SocketIOClient! = SocketIOClient(socketURL: NSURL(string: Router.baseURLString )! as URL, config:  [.path("/api/ws"),.log(true), .forcePolling(true),.extraHeaders(["Authorization": ("Bearer " + AskParrotUI.getToken())])])
    override init() {
        super.init()
        print(AskParrotUI.getToken())
    }
    
    func establishConnection() {
        if socket != nil && socket.status != .connected {
            socket.connect()
        }
        else{
            socket = SocketIOClient(socketURL: NSURL(string: Router.baseURLString)! as URL, config: [.path("/api/ws"), .log(true), .forcePolling(true),
                    .extraHeaders(["Authorization": ("Bearer " + AskParrotUI.getToken())])])

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
    
    func emitFor(key : String, value: String)  {
        if socket.status == .connected{
            socket.emit(key, value)
            self.key = key
            self.value = value
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
