//
//  AskParrotUI.swift
//  AskParrot
//
//  Created by Hemant Singh on 10/02/17.
//
//

import Foundation
import UIKit

public class AskParrotUI {
    
    static let expectedConfigVersion = 1
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
        if AskParrot.getToken() != "" {
            AskParrot.parrotPing()
            
        }
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
}
