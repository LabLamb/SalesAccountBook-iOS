//
//  Copyright © 2020 LabLambWorks. All rights reserved.
//

import SnapKit
import CoreData

class OrderCell: CustomCell {
    
    lazy var iconStack: UIStackView = {
        let result = UIStackView()
        result.axis = .horizontal
        result.distribution = .equalCentering
        result.alignment = .center
        return result
    }()
    lazy var orderNumLabel: UILabel = {
        let result = UILabel()
        result.textColor = .accent
        result.font = Constants.UI.Font.Plain.Small
        return result
    }()
    
    lazy var dateLabel: UILabel = {
        let result = UILabel()
        result.font = Constants.UI.Font.Plain.Small
        result.textColor = .accent
        return result
    }()
    
    lazy var custNameLabel: UILabel = {
        let result = UILabel()
        result.font = Constants.UI.Font.Plain.Medium
        result.textColor = .text
        return result
    }()
    
    lazy var custPhoneLabel: UILabel = {
        let result = UILabel()
        result.font = Constants.UI.Font.Plain.Small
        result.textColor = .accent
        return result
    }()
    
    lazy var isShippedIcon: UIImageView = {
        let icon = #imageLiteral(resourceName: "isShipped").withRenderingMode(.alwaysTemplate)
        let result = UIImageView(image: icon)
        result.tintColor = .text
        result.alpha = 0.1
        return result
    }()
    
    lazy var isPrepedIcon: UIImageView = {
        let icon = #imageLiteral(resourceName: "isPreped").withRenderingMode(.alwaysTemplate)
        let result = UIImageView(image: icon)
        result.tintColor = .text
        result.alpha = 0.1
        return result
    }()
    
    lazy var isPaidIcon: UIImageView = {
        let icon = #imageLiteral(resourceName: "isPaid").withRenderingMode(.alwaysTemplate)
        let result = UIImageView(image: icon)
        result.tintColor = .text
        result.alpha = 0.1
        return result
    }()
    
    lazy var isDepositIcon: UIImageView = {
        let icon = #imageLiteral(resourceName: "isDeposit").withRenderingMode(.alwaysTemplate)
        let result = UIImageView(image: icon)
        result.tintColor = .text
        result.alpha = 0.1
        return result
    }()
    
    lazy var profitLabel: IconWithTextLabelInside = {
        let result = IconWithTextLabelInside(icon: #imageLiteral(resourceName: "OrderNum").withRenderingMode(.alwaysTemplate))
        result.icon.tintColor = .accent
        result.icon.alpha = 0.075
        result.textLabel.textColor = .text
        result.textLabel.font = Constants.UI.Font.Bold.Medium
        result.textLabel.textAlignment = .center
        return result
    }()
    
    override func setupLayout() {
        super.setupLayout()
        
        self.paddingView.addSubview(self.dateLabel)
        self.dateLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(Constants.UI.Spacing.Height.Small)
            make.height.equalTo(self.dateLabel.font.lineHeight)
            make.right.equalToSuperview().offset(-Constants.UI.Spacing.Width.Medium * 1.5)
        }
        
        self.paddingView.addSubview(self.orderNumLabel)
        self.orderNumLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(Constants.UI.Spacing.Height.Small)
            make.height.equalTo(self.orderNumLabel.font.lineHeight)
            make.left.equalToSuperview().offset(Constants.UI.Spacing.Width.Medium * 1.5)
        }
        
        self.paddingView.addSubview(self.custNameLabel)
        self.custNameLabel.snp.makeConstraints { make in
            make.top.equalTo(self.orderNumLabel.snp.bottom)
            make.height.equalTo(self.custNameLabel.font.lineHeight)
            make.left.equalToSuperview().offset(Constants.UI.Spacing.Width.Medium * 1.5)
        }

        self.paddingView.addSubview(self.custPhoneLabel)
        self.custPhoneLabel.snp.makeConstraints { make in
            make.top.equalTo(self.custNameLabel.snp.bottom)
            make.height.equalTo(self.custPhoneLabel.font.lineHeight)
            make.left.equalToSuperview().offset(Constants.UI.Spacing.Width.Medium * 1.5)
        }
        
        [self.isDepositIcon,
         self.isPrepedIcon,
         self.isPaidIcon,
         self.isShippedIcon].forEach({ icon in
            self.iconStack.addArrangedSubview(icon)
            icon.snp.makeConstraints { make in
                make.top.bottom.equalToSuperview()
                make.width.equalTo(icon.snp.height)
            }
         })
        
        self.paddingView.addSubview(self.iconStack)
        self.iconStack.snp.makeConstraints { make in
            make.top.equalTo(self.custPhoneLabel.snp.bottom).offset(Constants.UI.Spacing.Height.Small)
            make.bottom.equalToSuperview().offset(-Constants.UI.Spacing.Height.Small)
            make.left.equalToSuperview().offset(Constants.UI.Spacing.Width.Medium * 1.5)
            make.width.equalTo(self.iconStack.snp.height).multipliedBy(self.iconStack.arrangedSubviews.count + 1)
        }
        
        self.paddingView.addSubview(self.profitLabel)
        self.profitLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(Constants.UI.Spacing.Height.Medium)
            make.right.equalToSuperview().offset(-Constants.UI.Spacing.Height.Small)
            make.bottom.equalToSuperview()
            make.width.equalTo(self.profitLabel.snp.height)
        }
    }
    
    override func setupData(data: NSManagedObject) {
        guard let `data` = data as? Order else { return }
        
        self.orderNumLabel.text = "#\(data.number)"
        self.dateLabel.text = data.openedOn?.toString(format: Constants.System.DateFormat)
        self.custNameLabel.text = data.customer.name
        self.custPhoneLabel.text = data.customer.phone == "" ? "N/A" : data.customer.phone
        
        let orderItems = data.items
        let totalProfit = orderItems?.compactMap({ $0.price * Double($0.qty) }).reduce(0, +).toLocalCurrencyWithoutFractionDigits() ?? "0"
        self.profitLabel.text = "$\(totalProfit)"
        
        if data.isShipped {
            self.isShippedIcon.tintColor = .buttonIcon
            self.isShippedIcon.alpha = 1
        }
        
        if data.isPaid {
            self.isPaidIcon.tintColor = .buttonIcon
            self.isPaidIcon.alpha = 1
        }
        
        if data.isDeposit {
            self.isDepositIcon.tintColor = .buttonIcon
            self.isDepositIcon.alpha = 1
        }
        
        if data.isPreped {
            self.isPrepedIcon.tintColor = .buttonIcon
            self.isPrepedIcon.alpha = 1
        }
        
        if data.isClosed {
            self.profitLabel.icon.image = #imageLiteral(resourceName: "isClosed").withRenderingMode(.alwaysTemplate)
        }
    }
    
    override func prepareForReuse() {
        self.orderNumLabel.text = ""
        self.profitLabel.icon.image = #imageLiteral(resourceName: "OrderNum").withRenderingMode(.alwaysTemplate)
        
        self.iconStack.arrangedSubviews.forEach({ icon in
            icon.tintColor = .text
            icon.alpha = 0.1
            icon.isHidden = false
        })
    }
}
