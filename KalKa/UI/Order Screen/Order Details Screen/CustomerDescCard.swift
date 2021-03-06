//
//  Copyright © 2020 LabLambWorks. All rights reserved.
//

import SnapKit
import PNPForm

class CustomerDescCard: CustomView {
    
    let icon: UIImageView
    
    lazy var nameLabel: UILabel = {
        let result = UILabel()
        result.font = Constants.UI.Font.Plain.Medium
        result.textAlignment = .center
        return result
    }()
    
    lazy var phoneLabel: UILabel = {
        let result = UILabel()
        result.font = Constants.UI.Font.Plain.Small
        result.textColor = .accent
        result.textAlignment = .center
        return result
    }()
    
    lazy var addressLabel: UILabel = {
        let result = UILabel()
        result.font = Constants.UI.Font.Plain.Small
        result.textColor = .accent
        result.numberOfLines = 0
        result.textAlignment = .center
        return result
    }()
    
    weak var delegate: DataPicker?
    
    let placeholder: IconWithTextLabel = {
        let plusImg = UIImage(named: "Plus") ?? UIImage()
        let textField = PNPTextField()
        let result = IconWithTextLabel(icon: plusImg.withRenderingMode(.alwaysTemplate), textField: textField, spacing: Constants.UI.Spacing.Width.Medium * 0.75)
        textField.text = .customers
        textField.textColor = .buttonIcon
        textField.font = Constants.UI.Font.Plain.ExLarge
        result.iconImageView.tintColor = .buttonIcon
        return result
    }()
    
    override init() {
        self.icon = UIImageView()
        
        super.init()
        
        let tapGest = UITapGestureRecognizer(target: self, action: #selector(self.pickCustomer))
        self.addGestureRecognizer(tapGest)
        self.isUserInteractionEnabled = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func pickCustomer() {
        self.delegate?.pickCustomer()
    }
    
    override func setupLayout() {
        
        self.placeholder.removeFromSuperview()
        self.icon.removeFromSuperview()
        self.nameLabel.removeFromSuperview()
        self.phoneLabel.removeFromSuperview()
        self.addressLabel.removeFromSuperview()
        
        self.addSubview(self.placeholder)
        self.placeholder.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
        self.addSubview(self.icon)
        self.icon.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(Constants.UI.Spacing.Height.Small)
            make.height.equalTo(Constants.UI.Sizing.Height.Small)
            make.centerX.equalToSuperview()
            make.width.equalTo(self.icon.snp.height)
        }
        
        self.addSubview(self.nameLabel)
        self.nameLabel.snp.makeConstraints { make in
            make.top.equalTo(self.icon.snp.bottom).offset(Constants.UI.Spacing.Height.Small)
            make.left.equalToSuperview().offset(Constants.UI.Spacing.Width.Small)
            make.right.equalToSuperview().offset(-Constants.UI.Spacing.Width.Small)
        }
        
        self.addSubview(self.phoneLabel)
        self.phoneLabel.snp.makeConstraints { make in
            make.top.equalTo(self.nameLabel.snp.bottom)
            make.left.equalToSuperview().offset(Constants.UI.Spacing.Width.Small)
            make.right.equalToSuperview().offset(-Constants.UI.Spacing.Width.Small)
        }
        
        self.addSubview(self.addressLabel)
        self.addressLabel.snp.makeConstraints { make in
            make.top.equalTo(self.phoneLabel.snp.bottom).offset(Constants.UI.Spacing.Height.ExSmall)
            make.left.equalToSuperview().offset(Constants.UI.Spacing.Width.Small)
            make.right.equalToSuperview().offset(-Constants.UI.Spacing.Width.Small)
            make.bottom.equalToSuperview().offset(-Constants.UI.Spacing.Height.Small)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.icon.clipsToBounds = true
        self.icon.layer.cornerRadius = self.icon.bounds.width / 2
    }
    
}
