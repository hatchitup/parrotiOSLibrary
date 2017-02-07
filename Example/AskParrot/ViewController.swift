//
//  ViewController.swift
//  AskParrot
//
//  Created by hrajput4@gmail.com on 02/07/2017.
//  Copyright (c) 2017 hrajput4@gmail.com. All rights reserved.
//

import UIKit
import AskParrot
class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func helpAction(_ sender: UIButton) {
        AskParrotUI.performSegueToHelpdesk(caller: self)
    }
}

