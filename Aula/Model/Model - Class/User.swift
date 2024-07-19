//
//  User.swift
//  Aula2
//
//  Created by Mohamad Lobo on 12/07/24.
//

import Foundation

class User {
    
    var id : Int = -1
    
    var ProfileImage : String = ""
    
    var lastLogin : String = ""
        
    var email : String = ""
    
    var name : String = ""
    
    var isAdmin : Bool = false
    
    var isActive : Bool = false
    
    var isDeleted : Bool = false
    
    var forgotPasswordHash : String = ""
    
    var forgotPasswordExpire : String = ""
    
    var createdAt : String = ""
        
    var updatedAt : String = ""
}
