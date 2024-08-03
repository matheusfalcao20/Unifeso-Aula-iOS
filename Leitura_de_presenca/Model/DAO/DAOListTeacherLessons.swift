//
//  DAOListTeacherLessons.swift
//  Leitura_de_presenca
//
//  Created by Mohamad Lobo on 01/08/24.
//

import Foundation
import CoreData
import UIKit

class DAOListTeacherLessons {
    
    fileprivate init() {
        
    }
    
    static func transformJSONInArrayListTeacherLessons(_ JSON : AnyObject) -> [ListTeacherLessons] {
        
        var array : [ListTeacherLessons] = []
        
        guard let data = JSON as? NSArray else {
            return array
        }
        
        for item in data {
            
            array.append(transformJSONInListTeacherLessons(item as AnyObject))
            
        }
        
        return array
        
    }
    
    static func transformJSONInListTeacherLessons(_ JSON : AnyObject) -> ListTeacherLessons {
        
        let item = ListTeacherLessons()
        
        if let info = JSON["id"] as? Int {
            item.id = info
        }
        
        if let info = JSON["students"] as? [[String : Any]] {
            item.students = DAOLessonStudent.transformJSONInArrayLessonStudent(info as AnyObject)
        }
        
        if let info = JSON["lesson_name"] as? String {
            item.lessonName = info
        }
        
        if let info = JSON["code"] as? String {
            item.code = info
        }
        
        if let info = JSON["created_at"] as? String {
            item.createdAt = info
        }
        
        if let info = JSON["updated_at"] as? String {
            item.updatedAt = info
        }
        
        if let info = JSON["class_teacher"] as? Int {
            item.classTeacher = info
        }
        
        return item
        
    }
}
