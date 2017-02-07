//
//  AskParrotUI.swift
//  Pods
//
//  Created by Hemant Singh on 07/02/17.
//
//

import Foundation
import UIKit


public class AskParrotUI {
    
    static let expectedConfigVersion = 1
    
    static var config = Config()
    
    public init() {
    }
    
   
    
    /**
     performs segue to elements profile screen
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
    public static func profileViewController() -> HelpDeskViewController {
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
