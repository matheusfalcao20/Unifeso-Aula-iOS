//
//  LessonStudent.swift
//  Leitura_de_presenca
//
//  Created by Mohamad Lobo on 01/08/24.
//

class LessonStudent: Hashable {
    var id: Int = -1
    
    var userObj: Students!
    
    var isPresent: Bool = false
    
    var createdAt: String = ""
    
    var updatedAt: String = ""
    
    var lesson: Int = -1
    
    var student : Int = -1
    
    static func == (lhs: LessonStudent, rhs: LessonStudent) -> Bool {
        return lhs.id == rhs.id &&
        lhs.userObj == rhs.userObj &&
        lhs.isPresent == rhs.isPresent &&
        lhs.createdAt == rhs.createdAt &&
        lhs.updatedAt == rhs.updatedAt &&
        lhs.lesson == rhs.lesson &&
        lhs.student == rhs.student
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(userObj)
        hasher.combine(isPresent)
        hasher.combine(createdAt)
        hasher.combine(updatedAt)
        hasher.combine(lesson)
        hasher.combine(student)
    }
}
