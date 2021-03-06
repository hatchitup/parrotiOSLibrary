//
//  APLoginViewController.swift
//  AskParrot
//
//  Created by Hemant Singh on 10/02/17.
//
//
//

import UIKit

class APLoginViewController: UIViewController {

    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var phoneField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var locationField: UITextField!
    @IBOutlet weak var queryField: UITextView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    var user : APUser!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        user = PersistencyManager.getUser()
        nameField.text = user.name
        phoneField.text = user.phone
        emailField.text = user.email
        locationField.text = user.location
        activityIndicator.stopAnimating()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func submitAction(_ sender: UIButton) {
        activityIndicator.startAnimating()
        if user.name != nil && queryField.isNotEmpty() {
           raiseTicket()
        }
        else if nameField.isNotEmpty() && emailField.isNotEmpty() && locationField.isNotEmpty()  && phoneField.isNotEmpty() {
            let u = APUser.init(name: nameField.text!, phone: phoneField.text!, email: emailField.text!, location: locationField.text!)
            u.registerUser(completion: { (result) in
                DispatchQueue.main.async {
                    self.activityIndicator.stopAnimating()}
                switch result {
                case true:
                    if self.queryField.isNotEmpty() {
                        self.raiseTicket()
                    }
                    else {
                        AskParrot.parrotPing()
                        DispatchQueue.main.async {
                            self.popViewController()
                        }
                    }
                case false:
                    AlertFactory.defaultAlert(caller: self)
                }
            })
            }
    }
    func raiseTicket(){
        APTicket.raiseTicket(text: self.queryField.text!) { (result) in
            switch result {
            case true:
                AskParrot.parrotPing()
                DispatchQueue.main.async {
                    self.popViewController()
                }
            case false:
                DispatchQueue.main.async {
                    AlertFactory.defaultAlert(caller: self)
                }
 
            }
        }
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
