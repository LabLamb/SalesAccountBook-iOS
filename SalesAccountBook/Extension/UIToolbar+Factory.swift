//
//  Copyright © 2020 LabLambWorks. All rights reserved.
//

import UIKit

extension UIToolbar {
    static func makeKeyboardToolbar(target: Any?, doneAction: Selector) -> UIToolbar {
        let result = UIToolbar(frame: .init(x: 0, y: 0, width: Constants.System.SupportedMiniumScreenWidth, height: 0))
        result.sizeToFit()
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.done, target: target, action: doneAction)
        
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)

        result.setItems([spaceButton, doneButton], animated: false)
        return result
    }
    
    static func makeKeyboardToolbar(target: Any?, doneAction: Selector, cancelAction: Selector) -> UIToolbar {
        let result = UIToolbar(frame: .init(x: 0, y: 0, width: Constants.System.SupportedMiniumScreenWidth, height: 0))
        result.sizeToFit()

        let cancelButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.cancel, target: target, action: cancelAction)
        
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.done, target: target, action: doneAction)

        result.setItems([cancelButton, spaceButton, doneButton], animated: false)
        
        return result
    }
}