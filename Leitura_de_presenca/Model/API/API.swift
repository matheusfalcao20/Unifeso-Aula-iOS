//
//  API.swift
//  Aula2
//
//  Created by Mohamad Lobo on 12/07/24.
//

import Foundation
import Alamofire
import UIKit

class API_Aluno {
    
    static let getUser = "https://unifesoios.noclaf.com.br/core/get-user/"
    
    static let auth = "https://unifesoios.noclaf.com.br/core/auth-student/"
    
    static let sharedInstance = API_Aluno()

    var sessionManager: Session!
    
    fileprivate init() {

        let headers = HTTPHeaders()

        let configuration = URLSessionConfiguration.default

        configuration.headers = headers

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

        sessionManager = Alamofire.Session(configuration: configuration)

    }
}
