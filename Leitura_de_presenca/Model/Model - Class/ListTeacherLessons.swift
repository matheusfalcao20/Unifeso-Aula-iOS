//
//  ListTeacherLessons.swift
//  Leitura_de_presenca
//
//  Created by Mohamad Lobo on 01/08/24.
//

import Foundation

class ListTeacherLessons: Hashable {
    var id: Int = -1
    
    var students: [LessonStudent] = []
    
    var lessonName: String = ""
    
    var code : String = ""
    
    var createdAt: String = ""
    
    var updatedAt: String = ""
    
    var classTeacher: Int = -1
    
    static func == (lhs: ListTeacherLessons, rhs: ListTeacherLessons) -> Bool {
        return lhs.id == rhs.id &&
        lhs.students == rhs.students &&
        lhs.lessonName == rhs.lessonName &&
        lhs.code == rhs.code &&
        lhs.createdAt == rhs.createdAt &&
        lhs.updatedAt == rhs.updatedAt &&
        lhs.classTeacher == rhs.classTeacher
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(students)
        hasher.combine(lessonName)
        hasher.combine(code)
        hasher.combine(createdAt)
        hasher.combine(updatedAt)
        hasher.combine(classTeacher)
    }
}
