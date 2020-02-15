//
//  Copyright © 2020 LabLambWorks. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class CustomerList: ViewModel {
    
    override func fetch(completion: (() -> Void)? = nil) {
        let sortDesc = NSSortDescriptor(key: "name", ascending: true)
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Customer")
        fetchRequest.sortDescriptors = [sortDesc]
        let result = try? self.persistentContainer.viewContext.fetch(fetchRequest) as? [Customer]
        self.items = result ?? [Customer]()
        completion?()
    }
    
    override func add(details: Any, completion: ((Bool) -> Void)) {
        guard let `details` = details as? CustomerDetails else {
            fatalError("Passed wrong datatype to add.")
        }
        
        let context = self.persistentContainer.newBackgroundContext()
        if let entity = NSEntityDescription.entity(forEntityName: "Customer", in: context) {
            let newCustomer = Customer(entity: entity, insertInto: context)
            
            newCustomer.name = details.name
            newCustomer.address = details.address
            newCustomer.phone = details.phone
            newCustomer.remark = details.remark
            newCustomer.lastContacted = Date()
            newCustomer.image = details.image?.pngData()
            
            try? context.save()
            
            self.fetch()
        }
    }
    
    override func query(clause: NSPredicate, incContext: NSManagedObjectContext? = nil) -> [Any]? {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Customer")
        fetchRequest.predicate = clause
        if let context = incContext {
            return try? context.fetch(fetchRequest) as? [Customer]
        } else {
            return try? self.persistentContainer.viewContext.fetch(fetchRequest) as? [Customer]
        }
        
    }
    
    override func get(name: String) -> Any? {
        let predicate = NSPredicate(format: "name = %@", name)
        guard let result = self.query(clause: predicate) as? [Customer] else { return nil}
        guard let customer = result.first else { return nil }
        let customerImage: UIImage? = {
            if let imgData = customer.image {
                return UIImage(data: imgData)
            } else {
                return nil
            }
        }()
        
        return (image: customerImage, address: customer.address, lastContacted: customer.lastContacted, name: customer.name, phone: customer.phone, orders: customer.orders, remark: customer.remark)
    }
    
    override func edit(oldName: String, details: Any, completion: ((Bool) -> Void)) {
        guard let `details` = details as? CustomerDetails else {
            fatalError("Passed wrong datatype to add.")
        }
        
        if oldName == details.name {
            self.storeEdit(oldName: oldName, details: details)
            completion(true)
        } else {
            self.exists(name: details.name) { exists in
                if exists {
                    completion(false)
                } else {
                    self.storeEdit(oldName: oldName, details: details)
                    completion(true)
                }
            }
        }
    }
    
    private func storeEdit(oldName: String, details: CustomerDetails) {
        let context = self.persistentContainer.newBackgroundContext()
        let predicate = NSPredicate(format: "name = %@", oldName)
        
        guard let result = self.query(clause: predicate, incContext: context) as? [Customer] else {
            fatalError("Trying to edit an non-existing Customer. (Query returned nil)")
        }
        
        guard let editingCustomer = result.first else {
            fatalError("Trying to edit an non-existing Customer. (Array is empty)")
        }
        
        editingCustomer.name = details.name
        editingCustomer.address = details.address
        editingCustomer.phone = details.phone
        editingCustomer.remark = details.remark
        editingCustomer.lastContacted = details.lastContacted
        editingCustomer.image = details.image?.pngData()
        
        try? context.save()
    }
    
    override func exists(name: String, completion: ((Bool) -> Void)) {
        let predicate = NSPredicate(format: "name = %@", name)
        guard let result = self.query(clause: predicate) else { return }
        completion(result.count > 0)
    }
}
