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
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var table: UITableView!
    lazy var leftButton: UIBarButtonItem = {
        let image = UIImage.init(named: "default profile")?.withRenderingMode(.alwaysOriginal)
        let button  = UIBarButtonItem.init(customView: UIImageView.init(image: image))
        return button
    }()
    override public func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
//        setupView()
        // Do any additional setup after loading the view.
        table.rowHeight = UITableViewAutomaticDimension
        table.estimatedRowHeight = 80
            Alamofire.request(Router.FAQs()).responseSwiftyJSON { (response) in
                 DispatchQueue.main.async {
                    self.activityIndicator.stopAnimating()}
                switch response.result {
                case .success(let json):
                    print(json)
                    do {
                        self.datasource = FAQModel.init(fromJson: json)
                        self.table.reloadData()
                    } catch let error as NSError {
                        print(error)
                    }
                case .failure(let error):
                    print(error)
                }
        }
        self.title = AskParrotUI.config.appName
        if let id = PersistencyManager.getUser().id {
            User.info(forUserID: id, completion: { [weak weakSelf = self] (user) in
                let image = user.profilePic
                let contentSize = CGSize.init(width: 30, height: 30)
                UIGraphicsBeginImageContextWithOptions(contentSize, false, 0.0)
                let _  = UIBezierPath.init(roundedRect: CGRect.init(origin: CGPoint.zero, size: contentSize), cornerRadius: 14).addClip()
                image.draw(in: CGRect(origin: CGPoint.zero, size: contentSize))
                let path = UIBezierPath.init(roundedRect: CGRect.init(origin: CGPoint.zero, size: contentSize), cornerRadius: 14)
                path.lineWidth = 2
                UIColor.white.setStroke()
                path.stroke()
                let finalImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!.withRenderingMode(.alwaysOriginal)
                UIGraphicsEndImageContext()
                DispatchQueue.main.async {
                    weakSelf?.leftButton.image = finalImage
                    weakSelf = nil
                }
            })
        }
        applyConfiguration(config: AskParrotUI.config)
    }
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        self.searchBar.endEditing(true)
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
