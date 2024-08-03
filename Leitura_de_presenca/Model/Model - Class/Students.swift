//
//  Students.swift
//  Leitura_de_presenca
//
//  Created by Mohamad Lobo on 01/08/24.
//

import Foundation

class Students: Hashable {
    var id: Int = -1
    
    var profileImage: String = ""
    
    var lastLogin: String = ""
    
    var email: String = ""
    
    var name: String = ""
    
    var cpf: String = ""
    
    var typeUser: String = ""
    
    var registration: String = ""
    
    var birthday: String = ""
    
    var isAdmin: Bool = false
    
    var isActive: Bool = false
    
    var isDeleted: Bool = false
    
    var createdAt: String = ""
    
    var updatedAt: String = ""

    static func == (lhs: Students, rhs: Students) -> Bool {
        return lhs.id == rhs.id &&
               lhs.profileImage == rhs.profileImage &&
               lhs.lastLogin == rhs.lastLogin &&
               lhs.email == rhs.email &&
               lhs.name == rhs.name &&
               lhs.cpf == rhs.cpf &&
               lhs.typeUser == rhs.typeUser &&
               lhs.registration == rhs.registration &&
               lhs.birthday == rhs.birthday &&
               lhs.isAdmin == rhs.isAdmin &&
               lhs.isActive == rhs.isActive &&
               lhs.isDeleted == rhs.isDeleted &&
               lhs.createdAt == rhs.createdAt &&
               lhs.updatedAt == rhs.updatedAt
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(profileImage)
        hasher.combine(lastLogin)
        hasher.combine(email)
        hasher.combine(name)
        hasher.combine(cpf)
        hasher.combine(typeUser)
        hasher.combine(registration)
        hasher.combine(birthday)
        hasher.combine(isAdmin)
        hasher.combine(isActive)
        hasher.combine(isDeleted)
        hasher.combine(createdAt)
        hasher.combine(updatedAt)
    }
}
