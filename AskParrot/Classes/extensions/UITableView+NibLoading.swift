//
//  UITableView+NibLoading.swift


import UIKit

extension UITableView {
    func registerNibs(nibNames nibs: [String]) {
        let bundle = AskParrotUI.getBundle()
        
        for nib in nibs {
            let cellNib = UINib(nibName: nib, bundle: bundle)
            register(cellNib, forCellReuseIdentifier: nib)
        }
    }
}
