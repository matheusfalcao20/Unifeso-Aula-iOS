//
//  ListStudentLessons.swift
//  Leitura_de_presenca
//
//  Created by Mohamad Lobo on 01/08/24.
//

import Foundation

class ListStudentLessons: Hashable {
    var id: Int = -1
    
    var lessonName: String = ""
     
    var createdAt: String = ""
    
    var isPresented: Bool = false
    
    static func == (lhs: ListStudentLessons, rhs: ListStudentLessons) -> Bool {
        return lhs.id == rhs.id && lhs.lessonName == rhs.lessonName && lhs.createdAt == rhs.createdAt && lhs.isPresented == rhs.isPresented
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(lessonName)
        hasher.combine(createdAt)
        hasher.combine(isPresented)
    }
}
