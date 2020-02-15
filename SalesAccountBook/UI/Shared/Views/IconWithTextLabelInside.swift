//
//  Copyright © 2019 LabLambWorks. All rights reserved.
//

import SnapKit

class IconWithTextLabelInside: CustomView {
    
    let icon: UIImageView
    let textLabel: UILabel
    var text: String {
        get {
            return self.textLabel.text ?? ""
        }
        
        set {
            self.textLabel.text = newValue
        }
    }
    
    var spacing: CGFloat {
        didSet {
            self.layoutIfNeeded()
        }
    }
    
    init(icon: UIImage, text: String = "") {
        self.icon = UIImageView(image: icon)
        self.textLabel = UILabel()
        self.spacing = 0
        
        super.init()
        
        self.setupLayout()
    }
    
    override func setupLayout() {
        self.addSubview(self.icon)
        self.icon.snp.makeConstraints({ make in
            make.top.bottom.left.right.equalToSuperview()
        })
        
        self.addSubview(self.textLabel)
        self.textLabel.snp.makeConstraints({ make in
            make.centerY.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.7)
        })
        
        self.textLabel.text = text
        self.textLabel.textAlignment = .center
        self.textLabel.adjustsFontSizeToFitWidth = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
