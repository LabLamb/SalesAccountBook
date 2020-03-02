//
//  Copyright © 2020 LabLambWorks. All rights reserved.
//

import SnapKit

class InputFieldsSection: CustomView {
    
    let stackView: UIStackView
    let separatorColor: UIColor = .background
    
    init(fields: [CustomView]) {
        let sv = UIStackView()
        fields.forEach { view in
            sv.addArrangedSubview(view)
        }
        self.stackView = sv
        
        super.init()
        
        self.stackView.axis = .vertical
        self.stackView.alignment = .fill
        self.stackView.distribution = .fill
        self.stackView.alignment = .center
    }
    
    override func setupLayout() {
        self.addLine(position: .bottom, color: self.separatorColor, weight: 1.0)
        
        self.addSubview(self.stackView)
        self.stackView.snp.makeConstraints { make in
            make.top.bottom.left.right.equalToSuperview()
        }
        
        self.stackView.arrangedSubviews.forEach { view in
            view.snp.makeConstraints { make in
                
                switch view {
                case is IconView:
                    make.width.equalToSuperview()
                    make.height.equalTo(Constants.UI.Sizing.Height.Medium)
                case is OrderDetailsStatusIcons:
                    make.width.equalToSuperview().multipliedBy(0.95)
                    make.height.equalTo(Constants.UI.Sizing.Height.TextFieldDefault * 2)
                default:
                    make.width.equalToSuperview().multipliedBy(0.95)
                }
                view.backgroundColor = .primary
                view.addLine(position: .bottom, color: self.separatorColor, weight: 1)
            }
        }
    }
    
    public func getViews(descText: String) -> [UIView] {
        return self.extractFieldsViews().filter({ view in
            (view.desc as? String) == descText
        })
    }
    
    public func getViews(viewType: AnyClass) -> [UIView] {
        return self.stackView.arrangedSubviews.filter({ view in
            type(of: view) == viewType
        })
    }
    
    private func extractFieldsViews() -> [DescWithValue] {
        return self.stackView.arrangedSubviews.filter({ $0 is DescWithValue }) as! [DescWithValue]
    }
    
    public func prefillValues(values: [String: String]) {
        self.extractFieldsViews().forEach({ field in
            if let desc = field.desc as? String, let value = values[desc] {
                field.value = value
            }
        })
    }
    
    public func extractValues(mappingKeys: [String]) -> [String: String] {
        var result: [String: String] = [:]
        self.extractFieldsViews().forEach({ field in
            if let desc = field.desc as? String {
                result[desc] = field.value
            }
        })
        return result
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
