//
//  DAOStudents.swift
//  Leitura_de_presenca
//
//  Created by Mohamad Lobo on 01/08/24.
//

import Foundation
import CoreData
import UIKit

class DAOStudents {
    
    fileprivate init() {
        
    }
    
    static func transformJSONInArrayStudents(_ JSON : AnyObject) -> [Students] {
        
        var array : [Students] = []
        
        guard let data = JSON as? NSArray else {
            return array
        }
        
        for item in data {
            
            array.append(transformJSONInStudents(item as AnyObject))
            
        }
        
        return array
        
    }
    
    static func transformJSONInStudents(_ JSON : AnyObject) -> Students {
        
        let item = Students()
        
        if let info = JSON["id"] as? Int {
            item.id = info
        }
        
        if let info = JSON["profile_image"] as? String {
            item.profileImage = info
        }
        
        if let info = JSON["last_login"] as? String {
            item.lastLogin = info
        }
        
        if let info = JSON["email"] as? String {
            item.email = info
        }
        
        if let info = JSON["name"] as? String {
            item.name = info
        }
        
        if let info = JSON["cpf"] as? String {
            item.cpf = info
        }
        
        if let info = JSON["type_user"] as? String {
            item.typeUser = info
        }
        
        if let info = JSON["registration"] as? String {
            item.registration = info
        }
        
        if let info = JSON["birthday"] as? String {
            item.birthday = info
        }
        
        if let info = JSON["is_admin"] as? Bool {
            item.isAdmin = info
        }
        
        if let info = JSON["is_active"] as? Bool {
            item.isActive = info
        }
        
        if let info = JSON["is_deleted"] as? Bool {
            item.isDeleted = info
        }
        
        if let info = JSON["created_at"] as? String {
            item.createdAt = info
        }
        
        if let info = JSON["updated_at"] as? String {
            item.updatedAt = info
        }
        
        return item
        
    }
}
