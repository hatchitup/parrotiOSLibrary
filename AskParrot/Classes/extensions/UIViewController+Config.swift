//  Created by Hemant Singh on 07/02/17.
//
//
import UIKit

extension UIViewController {
    func applyConfiguration(config: Config) {
        if let navigationBar = navigationController?.navigationBar {
            navigationBar.barTintColor = AskParrotUI.config.navigationBarColor
            navigationBar.tintColor = AskParrotUI.config.navigationBarTextColor
            navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: AskParrotUI.config.navigationBarTextColor]
        }
        view.backgroundColor = config.backgroundColor
    }
}
