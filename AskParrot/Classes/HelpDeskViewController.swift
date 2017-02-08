//
//  HelpDeskViewController.swift
//  Pods
//
//  Created by Hemant Singh on 07/02/17.
//
//

import UIKit
import Alamofire
import SwiftyJSON

public class HelpDeskViewController: UIViewController {

    private var ID : String!
    fileprivate var datasource : FAQModel! = FAQModel()
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var table: UITableView!
    override public func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
//        setupView()
        // Do any additional setup after loading the view.
        table.rowHeight = UITableViewAutomaticDimension
        table.estimatedRowHeight = 80
            Alamofire.request(Router.FAQs()).responseJSON { (response) in
                switch response.result {
                case .success:
                    do {
                        self.datasource = FAQModel.init(fromJson: JSON(response.data))
                        self.table.reloadData()
                    } catch let error as NSError {
                        print(error)
                    }
                case .failure(let error):
                    print(error)
                }
        }
    }
    public override func viewWillAppear(_ animated: Bool) {
        let n = self.navigationController!.viewControllers.count - 2
        if n < 0 {
            let backButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(HelpDeskViewController.popViewController))
            backButton.tintColor = UIColor.white
            navigationItem.leftBarButtonItem = backButton
        }
       
    }
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    override public func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func emailAction(_ sender: UIButton) {
        switch sender.tag {
        case 11:
            break
        case 22:
            self.performSegue(withIdentifier: "loginPop", sender: self)
        case 33:
            break
        default:
            break
        }
        
    }
    @objc private func bottomButtonsAction(sender : UIButton) {
        
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
    @IBAction func unwindToBaseViewController(segue: UIStoryboardSegue) {
        print("Unwind to Root View Controller")
        
    }
    
    // MARK: - Navigation
     func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        if segue.identifier == "loginPop" {
//            let popoverViewController = segue.destination as! UIViewController
//            popoverViewController.modalPresentationStyle = UIModalPresentationStyle.popover
//        }
    }
 

}
extension HelpDeskViewController : UISearchBarDelegate {
    public func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if searchBar.text != "" {
            
        }
    }
}
extension HelpDeskViewController : UITableViewDelegate, UITableViewDataSource {
    public func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.datasource.data.count
    }
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "faqCellID", for: indexPath) as! faqCell
        cell.questionLabel.text = String(repeating: datasource.data[indexPath.row].question, count: 50)
        cell.answerLabel.text = String(repeating: datasource.data[indexPath.row].answer, count: 50)
        return cell
    }
    
   
}
 class faqCell: UITableViewCell {
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var answerLabel: UILabel!
}
