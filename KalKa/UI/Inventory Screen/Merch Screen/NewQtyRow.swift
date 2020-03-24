//
//  Copyright © 2020 LabLambWorks. All rights reserved.
//

import PNPForm

class NewQtyRow: BaseRow {
    
    let labelView: UILabel
    let textField: UITextField
    var onChangeDelegate: ((Int) -> Void)?
    
    override var label: Any {
        get {
            return self.labelView.text as Any
        }
        
        set {
            self.labelView.text = newValue as? String
        }
    }
    
    override var value: String? {
        get {
            return self.textField.text ?? ""
        }
        
        set {
            self.textField.text = newValue
        }
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 0, height: PNPFormConstants.UI.BaseRowDefaultHeight)
    }
    
    init(textFieldOnChange: @escaping (Int) -> Void) {
        let labelView = UILabel()
        labelView.text = .restock
        let textField = UITextField()
        textField.keyboardType = .numberPad
        
        self.labelView = labelView
        self.textField = textField
        self.onChangeDelegate = textFieldOnChange
        
        super.init(labelView: labelView,
                   valueView: textField,
                   spacing: PNPFormConstants.UI.RowConfigDefaultSpacing,
                   labelWidth: PNPFormConstants.UI.RowConfigDefaultLabelWidth,
                   validateOption: .required,
                   validatedHandling: .default)
        
        self.textField.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension NewQtyRow: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text,
            let newValue = Int(text + string) else { return true }
        if string == "" && textField.text?.count == 1 {
            self.onChangeDelegate?(0)
        } else {
            self.onChangeDelegate?(newValue)
        }
        return true
    }
}