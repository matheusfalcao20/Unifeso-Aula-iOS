//
//  DAOListClass.swift
//  Leitura_de_presenca
//
//  Created by Mohamad Lobo on 01/08/24.
//

import Foundation
import CoreData
import UIKit

class DAOListClass {
    
    fileprivate init() {
        
    }
    
    static func transformJSONInArrayListClass(_ JSON : AnyObject) -> [ListClass] {
        
        var array : [ListClass] = []
        
        guard let data = JSON as? NSArray else {
            return array
        }
        
        for item in data {
            
            array.append(transformJSONInListClass(item as AnyObject))
            
        }
        
        return array
        
    }
    
    static func transformJSONInListClass(_ JSON : AnyObject) -> ListClass {
        
        let item = ListClass()
        
        if let info = JSON["id"] as? Int {
            item.id = info
        }
        
        if let info = JSON["students"] as? [[String : Any]] {
            item.students = DAOStudents.transformJSONInArrayStudents(info as AnyObject)
        }
        
        if let info = JSON["class_name"] as? String {
            item.className = info
        }
        
        if let info = JSON["created_at"] as? String {
            item.createdAt = info
        }
        
        if let info = JSON["updated_at"] as? String {
            item.updatedAt = info
        }
        
        if let info = JSON["user"] as? Int {
            item.user = info
        }
        
        return item
        
    }
}
