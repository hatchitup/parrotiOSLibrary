//
//  TextViewExt.swift
//  HAIP
//
//  Created by Hemant Singh on 09/12/16.
//  Copyright © 2016 Hemant Singh. All rights reserved.
//

import Foundation
import UIKit


extension UITextView {
    func isNotEmpty() -> Bool {
        return self.text != nil && self.text?.characters.count != 0
    }
}
