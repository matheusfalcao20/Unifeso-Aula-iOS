//
//  DAOUser.swift
//  Aula2
//
//  Created by Mohamad Lobo on 12/07/24.
//

import Foundation
import CoreData
import UIKit

class DAOUser {
    
    fileprivate init() {
        
    }
    
    static func transformJSONInArrayUser(_ JSON : AnyObject) -> [User] {
        
        var array : [User] = []
        
        guard let data = JSON as? NSArray else {
            return array
        }
        
        for item in data {
            
            array.append(transformJSONInUser(item as AnyObject))
            
        }
        
        return array
        
    }
    
    static func transformJSONInUser(_ JSON : AnyObject) -> User {
        
        let item = User()
        
        if let info = JSON["id"] as? Int {
            item.id = info
        }
        
        if let info = JSON["profile_image"] as? String {
            item.ProfileImage = info
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
        
        if let info = JSON["is_admin"] as? Bool {
            item.isAdmin = info
        }
        
        if let info = JSON["is_active"] as? Bool {
            item.isActive = info
        }
        
        if let info = JSON["is_deleted"] as? Bool {
            item.isDeleted = info
        }
        
        if let info = JSON["forgot_password_hash"] as? String {
            item.forgotPasswordHash = info
        }
        
        if let info = JSON["forgot_password_expire"] as? String {
            item.forgotPasswordExpire = info
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
