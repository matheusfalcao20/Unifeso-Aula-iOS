//
//  ServerResponse.swift
//  Aula2
//
//  Created by Mohamad Lobo on 12/07/24.
//

import Foundation
import UIKit

class ServerResponse {
    
    var user : User!
    var listStudentLessons : [ListStudentLessons] = []
    var listClass : [ListClass] = []
    var listTeacherLessons : [ListTeacherLessons] = []
    var student : [Students] = []
    var erroMessage : String = ""
    var statusCode : Int = 0
    var success : Bool = false
    
    init() {
        
    }
    
}

