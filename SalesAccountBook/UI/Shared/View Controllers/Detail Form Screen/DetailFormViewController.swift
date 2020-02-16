//
//  Copyright © 2020 LabLambWorks. All rights reserved.
//

import SnapKit

class DetailFormViewController: UIViewController {
    
    let scrollView: UIScrollView
    var itemExistsErrorMsg: String = ""
    var currentId: String?
    var list: ViewModel?
    
    init(config: DetailsConfigurator) {
        self.scrollView = UIScrollView()
        self.currentId = config.id
        self.list = config.viewModel
        
        super.init(nibName: nil, bundle: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardDidAppear(noti:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keboardDidDisappeared), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func keyboardDidAppear(noti: NSNotification) {
        guard let info = noti.userInfo else { return }
        let rect: CGRect = info[UIResponder.keyboardFrameBeginUserInfoKey] as! CGRect
        let kbSize = rect.size

        let insets = UIEdgeInsets(top: 0, left: 0, bottom: kbSize.height, right: 0)
        self.scrollView.contentInset = insets
        self.scrollView.scrollIndicatorInsets = insets
    }
    
    @objc private func keboardDidDisappeared() {
        self.scrollView.contentInset = UIEdgeInsets.zero
        self.scrollView.scrollIndicatorInsets = UIEdgeInsets.zero
    }
    
    // MARK: - Errors
    internal func promptItemExistsError() {
        self.present(UIAlertController.makeError(message: self.itemExistsErrorMsg), animated: true, completion: nil)
    }
    
    internal func promptEmptyFieldError(errorMsg: String, field: UITextField) {
        self.present(UIAlertController.makeError(message: errorMsg), animated: true, completion: nil)
        
        field.attributedPlaceholder = NSAttributedString(
            string: .required,
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.red.withAlphaComponent(0.5)])
    }
    
    internal func editItem(details: Any) {
        guard let oldId = self.currentId else {
            fatalError()
        }
        
        self.list?.edit(oldId: oldId,
                                details: details,
                                completion: { success in
                                    if success {
                                        self.navigationController?.popViewController(animated: true)
                                    } else {
                                        self.promptItemExistsError()
                                    }
        })
    }
}
