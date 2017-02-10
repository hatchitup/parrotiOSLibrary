//
//  PersistencyManager.swift


import UIKit

 class PersistencyManager {
    

   class func saveUser(user: User) {
    let filename = NSSearchPathForDirectoriesInDomains(.allLibrariesDirectory,.userDomainMask,true)[0] + "/APuser.bin"
    let data = NSKeyedArchiver.archivedData(withRootObject: user)
    try? data.write(to: URL(fileURLWithPath: filename), options: [.atomic])
  }
  
  class func getUser() -> User {
    if let data = try? Data(contentsOf: URL(fileURLWithPath: NSSearchPathForDirectoriesInDomains(.allLibrariesDirectory,.userDomainMask,true)[0] + "/APuser.bin")) {
        let unarchiveUser = NSKeyedUnarchiver.unarchiveObject(with: data) as! User?
        if (unarchiveUser != nil) {
            return unarchiveUser!
        }
        else{
            return User()
        }
    }
    else {
       return User()
    }
  }

}
