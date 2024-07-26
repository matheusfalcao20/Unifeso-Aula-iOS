//
//  API.swift
//  Aula2
//
//  Created by Mohamad Lobo on 12/07/24.
//

import Foundation
<<<<<<< HEAD
import Alamofire
import UIKit

class API_Aluno {
    
    static let getUser = "https://unifesoios.noclaf.com.br/core/get-user/"
    
    static let auth = "https://unifesoios.noclaf.com.br/core/auth-student/"
    
    static let sharedInstance = API_Aluno()

    var sessionManager: Session!
    
    fileprivate init() {

        let headers = HTTPHeaders()

=======
import UIKit
import Alamofire

class API {

    static let host = "https://unifesoios.noclaf.com.br/"
    
    static let getUser = "core/list-my-classes/"
    
    static let auth = "core/auth-user/"
    
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

>>>>>>> 4778bed (Helo iza)
        let configuration = URLSessionConfiguration.default

        configuration.headers = headers

<<<<<<< HEAD
        sessionManager = Alamofire.Session(configuration: configuration)

    }
}

class API_Professor {
    
    static let getUser = "https://unifesoios.noclaf.com.br/core/get-user/"
    
    static let auth = "https://unifesoios.noclaf.com.br/core/auth-teacher/"
    
    static let sharedInstance = API_Professor()

    var sessionManager: Session!
    
    fileprivate init() {

        let headers = HTTPHeaders()

        let configuration = URLSessionConfiguration.default

        configuration.headers = headers
=======
        //----------------------- Session Manager -----------------------------
>>>>>>> 4778bed (Helo iza)

        sessionManager = Alamofire.Session(configuration: configuration)

    }
<<<<<<< HEAD
}
=======

}

>>>>>>> 4778bed (Helo iza)
