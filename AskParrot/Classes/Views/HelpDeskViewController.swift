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
                    print(JSON(response.data))
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
        self.title = AskParrotUI.config.appName
        applyConfiguration(config: AskParrotUI.config)
    }
    public override func viewWillAppear(_ animated: Bool) {
        let n = self.navigationController!.viewControllers.count - 2
        if n < 0 {
            let backButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(HelpDeskViewController.popViewController))
            backButton.tintColor = UIColor.white
            navigationItem.rightBarButtonItem = backButton
        }
//       AppIcon
    }
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    override public func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        cell.questionLabel.text = datasource.data[indexPath.row].question
        cell.answerLabel.text = datasource.data[indexPath.row].answer
        return cell
    }
    
   
}
 class faqCell: UITableViewCell {
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var answerLabel: UILabel!
}
