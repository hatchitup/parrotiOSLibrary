//
//  AskParrotUI.swift
//  AskParrot
//
//  Created by Hemant Singh on 10/02/17.
//
//

import Foundation
import UIKit
import Alamofire
import SwiftyJSON

public class AskParrotUI {
    
    static let expectedConfigVersion = 1
    static let defaults: UserDefaults = UserDefaults(suiteName: "com.askparrot")!
    static var config = Config()
    public init() {
    }
    
    public static func start()  {
        if let path = Bundle.main.path(forResource: "config", ofType: "json"){
            do {
                let data = try NSData(contentsOf: URL(fileURLWithPath: path) , options: NSData.ReadingOptions.mappedIfSafe)
                AskParrotUI.config = try ConfigParser().parse(data: data)
            } catch let error as NSError {
                print("could not load config file! Error: \(error)")
            }
        }
        if AskParrotUI.getToken() != "" {
            parrotPing()
            
        }
    }
    public static func parrotPing(){
        Alamofire.request(Router.Ping()).responseJSON(completionHandler: { (response) in
            switch response.result {
            case .success:
                let user = User.init(fromJson: JSON(response.data))
                AskParrotUI.setToken(token: user.authToken)
                PersistencyManager.saveUser(user: user)
            case .failure(let error):
                print(error)
            }
        })
    }
    public static func setToken(token: String){
        defaults.set(token, forKey: APUDKeys.tokenKey.rawValue)
        defaults.synchronize()
    }
    public static func getToken() -> String {
       return defaults.string(forKey: APUDKeys.tokenKey.rawValue) ?? ""
    }
    /**
     performs segue to AskParrot HelpDesk screen
     - Parameter caller: calling UIViewController
     */
    public static func performSegueToHelpdesk(caller: UIViewController) {
        let vc = helpdeskStoryboard().instantiateInitialViewController()!
        caller.present(vc, animated: true, completion: nil)
    }
    
   
    
    /**
     instantiates a profile view controller from elements
     - Returns: elements profile view controller
     */
    public static func helpDeskViewController() -> HelpDeskViewController {
        return helpdeskStoryboard().instantiateViewController(withIdentifier: "HelpDeskViewController") as! HelpDeskViewController
    }
    
    
    private static func helpdeskStoryboard() -> UIStoryboard {
        return UIStoryboard (
            name: "HelpDesk", bundle: getBundle()
        )
    }
    
    static func getBundle() -> Bundle {
        let podBundle = Bundle(for: HelpDeskViewController.self)
        let bundleURL = podBundle.url(forResource: "AskParrot", withExtension: "bundle")
        return Bundle(url: bundleURL!)!
    }
    static func isPad() -> Bool {
        
        return UIDevice.current.userInterfaceIdiom == .pad
    }
    
    static func isPhone() -> Bool {
        
        return UIDevice.current.userInterfaceIdiom == .phone
    }
}
