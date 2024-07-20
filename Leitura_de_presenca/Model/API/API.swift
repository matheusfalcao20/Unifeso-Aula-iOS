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
    
    static let getUser = "https://unifesoios.noclaf.com.br/core/get-user/"
    
    static let auth = "https://unifesoios.noclaf.com.br/core/auth-user/"
    
    static let sharedInstance = API()

    var sessionManager: Session!
    
    fileprivate init() {

        let headers = HTTPHeaders()

        let configuration = URLSessionConfiguration.default

        configuration.headers = headers

        sessionManager = Alamofire.Session(configuration: configuration)

    }
}
