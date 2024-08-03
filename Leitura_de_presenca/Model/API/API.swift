//
//  API.swift
//  Aula2
//
//  Created by Mohamad Lobo on 12/07/24.
//

import Foundation
import Alamofire
import UIKit

class API {

    static let host = "https://unifesoios.noclaf.com.br/"
    
    static let authStudent = "core/auth-student/"
    
    static let authTeacher = "core/auth-teacher/"
    
    static let getUser = "core/get-user/"
    
    static let listStudentLessons = "core/list-my-student-lessons/"
    
    static let readQrCode = "core/read-code-and-present-lesson/"
    
    static let listClasses = "core/list-my-classes/"
    
    static let listTeacherLessons = "core/list-lessons/"
    
    static let creatLesson = "core/create-lesson/"
    
    static let creatClass = "core/create-class/"
    
    static let addStudent = "core/add-student-class/"
    
    //------------------------- Singleton -----------------------------

    static let sharedInstance = API()

    var sessionManager: Session!

    /* *********************************************************************************
     **
     **  MARK: Init
     **
     ***********************************************************************************/

    fileprivate init() {

        _ = Locale.preferredLanguages[0] as String

        //---------------------- Default Header ----------------------------

        let headers = HTTPHeaders()

        //----------------------- URLSessionConfiguration ---------------------

        let configuration = URLSessionConfiguration.default

        configuration.headers = headers

        //----------------------- Session Manager -----------------------------

        sessionManager = Alamofire.Session(configuration: configuration)

    }

}
