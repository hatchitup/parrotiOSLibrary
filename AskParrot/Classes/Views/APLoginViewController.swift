//
//  APLoginViewController.swift
//  AskParrot
//
//  Created by Hemant Singh on 10/02/17.
//
//
//

import UIKit
import Alamofire
import SwiftyJSON

class APLoginViewController: UIViewController {

    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var phoneField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var locationField: UITextField!
    @IBOutlet weak var queryField: UITextView!
    var user : User!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        user = PersistencyManager.getUser()
        nameField.text = user.name
        phoneField.text = user.phone
        emailField.text = user.email
        locationField.text = user.location
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func submitAction(_ sender: UIButton) {
        if user.name != nil && user.name != "" {
           raiseTicket()
        }
        else {
            if nameField.isNotEmpty() && emailField.isNotEmpty() && locationField.isNotEmpty()  && phoneField.isNotEmpty() {
            let u = User.init(name: nameField.text!, phone: phoneField.text!, email: emailField.text!, location: locationField.text!)
            let dict = u.toDictionary()
            let payload = dict as! [String: AnyObject]
            Alamofire.request(Router.Register(payload)).responseJSON(completionHandler:
                { (response) in
                    switch response.result {
                    case .success(let value):
                        let json = JSON(value)
                        print("JSON: \(json)")
                        let token = json["data"]["authToken"].stringValue
                        AskParrotUI.setToken(token: token)
                        
                        if self.queryField.isNotEmpty() {
                        self.raiseTicket()
                        }
                        else {
                            AskParrotUI.parrotPing()
                            self.popViewController()
                        }
                    case .failure(let error):
                        print(error)
                        AlertFactory.defaultAlert(caller: self)
                    }
            })
        }
            }
    }
    func raiseTicket(){
        let ticket = APQuery.init(msg: self.queryField.text!)
        Alamofire.request(Router.AddTicket(ticket.toDictionary() as! [String: AnyObject])).responseJSON(completionHandler: { (response) in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print("JSON: \(json)")
                AskParrotUI.parrotPing()
                 self.popViewController()
            case .failure(let error):
                print(error)
                AlertFactory.defaultAlert(caller: self)
            }
        })
    }
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
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

extension APLoginViewController : UITextViewDelegate, UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField.tag {
        case 11:
            phoneField.becomeFirstResponder()
            return false
        case 12:
            emailField.becomeFirstResponder()
            return false
        case 13:
            locationField.becomeFirstResponder()
            return false
        case 14:
            queryField.becomeFirstResponder()
            return false
        default:
            view.endEditing(true)
            return true
        }
    }
}
