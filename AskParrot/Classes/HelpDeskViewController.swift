//
//  HelpDeskViewController.swift
//  Pods
//
//  Created by Hemant Singh on 07/02/17.
//
//

import UIKit

public class HelpDeskViewController: UIViewController {

    private var ID : String!
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
//        setupView()
        // Do any additional setup after loading the view.
        
    }

    override public func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @objc private func bottomButtonsAction(sender : UIButton) {
        switch sender.tag {
        case 1:
            break
        case 2:
            break
        case 3:
            break
        default:
            break
        }
    }
    private func setupView(){
        let callButton = UIButton.init(type: .custom)
        callButton.setTitle("Call", for: .normal)
        callButton.setTitleColor(UIColor.black, for: .normal)
        callButton.backgroundColor = UIColor.lightGray
        callButton.tag = 1
        callButton.addTarget(self, action: #selector(HelpDeskViewController.bottomButtonsAction(sender:)), for: .touchUpInside)
        callButton.frame = CGRect.init(x: 10, y: view.frame.height - 50 , width: view.frame.width/4, height: 44)
        view.addSubview(callButton)
        let chatButton = UIButton.init(type: .custom)
        chatButton.setTitle("Live Chat", for: .normal)
        chatButton.tag = 2
        chatButton.backgroundColor = UIColor.lightGray
        chatButton.setTitleColor(UIColor.black, for: .normal)
        chatButton.addTarget(self, action: #selector(HelpDeskViewController.bottomButtonsAction(sender:)), for: .touchUpInside)
        chatButton.frame = CGRect.init(x: 20 + view.frame.width/4, y: view.frame.height - 50 , width: view.frame.width/4, height: 44)
        view.addSubview(chatButton)
        let emailButton = UIButton.init(type: .custom)
        emailButton.setTitle("Email", for: .normal)
        emailButton.tag = 3
        emailButton.backgroundColor = UIColor.lightGray
        emailButton.setTitleColor(UIColor.black, for: .normal)
        emailButton.addTarget(self, action: #selector(HelpDeskViewController.bottomButtonsAction(sender:)), for: .touchUpInside)
        emailButton.frame = CGRect.init(x: 30 + view.frame.width/2, y: view.frame.height - 50 , width: view.frame.width/4, height: 44)
        view.addSubview(emailButton)
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
