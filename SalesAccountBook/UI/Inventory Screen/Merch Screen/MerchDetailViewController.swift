//
//  Copyright © 2020 LabLambWorks. All rights reserved.
//

import SnapKit

class MerchDetailViewController: DetailFormViewController {
    
    // MARK: - Variables
    let inputFieldsSection: InputFieldsSection
    
    let actionType: DetailsViewActionType
    weak var inventory: Inventory?
    var onSelectRowDelegate: ((String) -> Void)?
    
    // MARK: - Initializion
    override init(config: DetailsConfigurator) {
        let iconView = IconView(image: #imageLiteral(resourceName: "MerchDefault"))
        
        let fields = [
            iconView,
            TitleWithTextField(title: .name, placeholder: .required),
            TitleWithTextField(title: .price, placeholder: .optional),
            TitleWithTextField(title: .quantity, placeholder: .optional),
            TitleWithTextField(title: .remark, placeholder: .optional),
        ]
        
        self.inputFieldsSection = InputFieldsSection(fields: fields)
        
        self.actionType = config.action
        self.inventory = config.viewModel as? Inventory
        self.onSelectRowDelegate = config.onSelectRow
        
        super.init(config: config)
        
        iconView.cameraOptionPresenter = self
        
        self.itemExistsErrorMsg = NSLocalizedString("ErrorMerchExists", comment: "Error Message - Merch name text field .")
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI
    override func viewDidLoad() {
        self.navigationItem.title = {
            if self.actionType == .edit {
                return "\(String.edit) \(self.currentId ?? "")"
            } else if self.actionType == .add {
                return NSLocalizedString("NewMerch", comment: "New entry of product.")
            } else {
                return ""
            }
        }()
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: NSLocalizedString("Save", comment: "The action of storing data on disc."), style: .done, target: self, action: #selector(self.submitMerchDetails))
        
        self.setup()
    }
    
    private func prefillFieldsForEdit() {
        guard let merchDetails = self.inventory?.get(name: self.currentId ?? "") as? MerchDetails else {
            fatalError()
        }
        
        let valueMap: [String: String] = [
            .name: merchDetails.name,
            .price: String(merchDetails.price),
            .quantity: String(merchDetails.qty),
            .remark: merchDetails.remark
        ]
        
        self.inputFieldsSection.prefillValues(values: valueMap)
    }
    
    private func setup() {
        self.view.backgroundColor = .groupTableViewBackground
        
        self.view.addSubview(self.inputFieldsSection)
        self.inputFieldsSection.snp.makeConstraints { make in
            make.top.equalTo(self.view.layoutMarginsGuide.snp.top)
            make.left.right.equalToSuperview()
        }
        self.inputFieldsSection.backgroundColor = .white
        
        if self.actionType == .edit {
            self.prefillFieldsForEdit()
        }
    }
    
    
    // MARK: - Data
    @objc private func submitMerchDetails () {
        let merchDetails = self.makeMerchDetails()
        if merchDetails.name == "" {
            let textField = self.inputFieldsSection
                .getView(viewType: TitleWithTextField.self)
                .first(where: { view in
                    let abc = (view as? TitleWithTextField)
                    let abcDesc = (abc?.desc as? String)
                    return abcDesc == .name
                }) as! TitleWithTextField
            self.promptEmptyFieldError(errorMsg: NSLocalizedString("ErrorMerchInputEmpty", comment: "Error Message - Merch name text field ."), field: textField.textView as! UITextField)
            return
        }
        
        let handler: (UIAlertAction) -> Void = { [weak self] alert in
            guard let `self` = self else { return }
            if self.actionType == .edit {
                self.editItem(details: merchDetails)
            } else if self.actionType == .add {
                self.addMerch(merchDetails: merchDetails)
            }
        }
        
        let confirmationAlert = UIAlertController.makeConfirmation(confirmHandler: handler)
        
        self.present(confirmationAlert, animated: true, completion: nil)
    }
    
    private func makeMerchDetails() -> MerchDetails {
        let extractedValue = self.inputFieldsSection.extractValues(valMapping: [
            .name,
            .price,
            .quantity,
            .remark
        ])
        
        let iconView = self.inputFieldsSection.getView(viewType: IconView.self).first as? IconView
        let image: UIImage? = {
            if let img = iconView?.iconImage.image {
                return img  == #imageLiteral(resourceName: "MerchDefault") ? nil : img
            } else {
                return nil
            }
        }()
        
        let parsedPrice = Double(extractedValue[.price] ?? "") ?? 0.0
        let parsedQty = Int(extractedValue[.quantity] ?? "") ?? 0
        
        return (name: extractedValue[.name] ?? "",
                price: parsedPrice,
                qty: parsedQty,
                remark: extractedValue[.remark] ?? "",
                image: image)
        
    }
    
    private func addMerch(merchDetails: MerchDetails) {
        self.inventory?.add(details: merchDetails, completion: { success in
            if !success {
                self.promptItemExistsError()
            }
        })
        
        if let delegate = self.onSelectRowDelegate {
            delegate(merchDetails.name)
        } else {
            self.navigationController?.popViewController(animated: true)
        }
    }
}
