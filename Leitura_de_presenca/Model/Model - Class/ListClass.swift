//
//  ListClass.swift
//  Leitura_de_presenca
//
//  Created by Mohamad Lobo on 01/08/24.
//

import Foundation

class ListClass: Hashable {
    var id: Int = -1
    
    var students: [Students] = []

    var className: String = ""
    
    var createdAt: String = ""
    
    var updatedAt: String = ""
    
    var user: Int = -1

    static func == (lhs: ListClass, rhs: ListClass) -> Bool {
        return lhs.id == rhs.id &&
               lhs.students == rhs.students &&
               lhs.className == rhs.className &&
               lhs.createdAt == rhs.createdAt &&
               lhs.updatedAt == rhs.updatedAt &&
               lhs.user == rhs.user
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(students)
        hasher.combine(className)
        hasher.combine(createdAt)
        hasher.combine(updatedAt)
        hasher.combine(user)
    }
}
