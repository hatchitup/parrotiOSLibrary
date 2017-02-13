//
//  PersistencyManager.swift
//  AskParrot
//
//  Created by Hemant Singh on 10/02/17.
//
//

import UIKit

 class PersistencyManager {
    

   class func saveUser(user: APUser) {
    let filename = NSSearchPathForDirectoriesInDomains(.allLibrariesDirectory,.userDomainMask,true)[0] + "/APuser.bin"
    let data = NSKeyedArchiver.archivedData(withRootObject: user)
    try? data.write(to: URL(fileURLWithPath: filename), options: [.atomic])
  }
  
  class func getUser() -> APUser {
    if let data = try? Data(contentsOf: URL(fileURLWithPath: NSSearchPathForDirectoriesInDomains(.allLibrariesDirectory,.userDomainMask,true)[0] + "/APuser.bin")) {
        let unarchiveUser = NSKeyedUnarchiver.unarchiveObject(with: data) as! APUser?
        if (unarchiveUser != nil) {
            return unarchiveUser!
        }
        else{
            return APUser()
        }
    }
    else {
       return APUser()
    }
  }

}
