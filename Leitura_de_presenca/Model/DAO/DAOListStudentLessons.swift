//
//  DAOListStudentLessons.swift
//  Leitura_de_presenca
//
//  Created by Mohamad Lobo on 01/08/24.
//

import Foundation
import CoreData
import UIKit

class DAOListStudentLessons {
    
    fileprivate init() {
        
    }
    
    static func transformJSONInArrayListStudentLessons(_ JSON : AnyObject) -> [ListStudentLessons] {
        
        var array : [ListStudentLessons] = []
        
        guard let data = JSON as? NSArray else {
            return array
        }
        
        for item in data {
            
            array.append(transformJSONInListStudentLessons(item as AnyObject))
            
        }
        
        return array
        
    }
    
    static func transformJSONInListStudentLessons(_ JSON : AnyObject) -> ListStudentLessons {
        
        let item = ListStudentLessons()
        
        if let info = JSON["id"] as? Int {
            item.id = info
        }
        
        if let info = JSON["lesson_name"] as? String {
            item.lessonName = info
        }
        
        if let info = JSON["created_at"] as? String {
            item.createdAt = info
        }
        
        if let info = JSON["is_present"] as? Bool {
            item.isPresented = info
        }
        
        return item
        
    }
}
