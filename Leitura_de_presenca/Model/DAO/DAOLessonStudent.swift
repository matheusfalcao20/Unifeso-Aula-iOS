//
//  DAOLessonStudent.swift
//  Leitura_de_presenca
//
//  Created by Mohamad Lobo on 01/08/24.
//

import Foundation
import CoreData
import UIKit

class DAOLessonStudent {
    
    fileprivate init() {
        
    }
    
    static func transformJSONInArrayLessonStudent(_ JSON : AnyObject) -> [LessonStudent] {
        
        var array : [LessonStudent] = []
        
        guard let data = JSON as? NSArray else {
            return array
        }
        
        for item in data {
            
            array.append(transformJSONInLessonStudent(item as AnyObject))
            
        }
        
        return array
        
    }
    
    static func transformJSONInLessonStudent(_ JSON : AnyObject) -> LessonStudent {
        
        let item = LessonStudent()
        
        if let info = JSON["id"] as? Int {
            item.id = info
        }
        
        if let info = JSON["user_obj"] as? [String : Any] {
            item.userObj = DAOStudents.transformJSONInStudents(info as AnyObject)
        }
        
        if let info = JSON["is_present"] as? Bool {
            item.isPresent = info
        }
        
        if let info = JSON["created_at"] as? String {
            item.createdAt = info
        }
        
        if let info = JSON["updated_at"] as? String {
            item.updatedAt = info
        }
        
        if let info = JSON["lesson"] as? Int {
            item.lesson = info
        }
        
        if let info = JSON["student"] as? Int {
            item.student = info
        }
        
        return item
        
    }
}
