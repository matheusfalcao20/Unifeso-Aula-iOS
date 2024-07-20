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
        
        if let info = JSON["email"] as? String {
            item.email = info
        }
        
        if let info = JSON["name"] as? String {
            item.name = info
        }
        
        if let info = JSON["registration"] as? String {
            item.registration = info
        }
        
        if let info = JSON["birthday"] as? String {
            item.birthday = info
        }
        
        return item
        
    }
}
