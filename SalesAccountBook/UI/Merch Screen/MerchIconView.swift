//
//  Copyright © 2020 LabLambWorks. All rights reserved.
//

import SnapKit

class MerchIconView: UIView {
    
    let iconImage: UIImageView
    
    init() {
        self.iconImage = UIImageView(image: #imageLiteral(resourceName: "MerchDefault"))
        super.init(frame: .zero)
        self.addSubview(self.iconImage)
        self.iconImage.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(Constants.UI.Spacing.Height.Small)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-Constants.UI.Spacing.Height.Small)
            make.width.equalTo(self.iconImage.snp.height)
        }
        self.iconImage.backgroundColor = Constants.UI.Color.Grey
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
