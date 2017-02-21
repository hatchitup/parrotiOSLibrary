//
//  CallMeViewController.swift
//  Pods
//
//  Created by Hemant Singh on 14/02/17.
//
//

import UIKit
import Alamofire
import SwiftyJSON

class CallMeViewController: UIViewController {

    @IBOutlet weak var phoneField: UITextField!
    @IBOutlet weak var fromField: UITextField!
    @IBOutlet weak var tillField: UITextField!
    @IBOutlet weak var prevSchedule: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        phoneField.text = PersistencyManager.getUser().phone
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    @IBAction func requestCallAction(_ sender: UIButton) {
        if phoneField.isNotEmpty()  {
            let payload = callQuery.init(phone: phoneField.text!)
            Alamofire.request(Router.RequestCall(payload.toDictionary() as! [String : AnyObject])).responseSwiftyJSON(completionHandler: { (response) in
                switch response.result {
                case .success(let json):
                    print("JSON: \(json)")
                    DispatchQueue.main.async
                    {
                    self.view.endEditing(true)
                    AlertFactory.successAlert(caller: self, msg: json["data"]["userMessage"].stringValue)
                        
                    }
                case .failure(let error):
                    print(error)
                    AlertFactory.defaultAlert(caller: self)
                }
            })
        }
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
