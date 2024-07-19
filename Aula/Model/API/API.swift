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
    
    static let getUser = "core/get-user/"
    
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

        let configuration = URLSessionConfiguration.default

        configuration.headers = headers

        //----------------------- Session Manager -----------------------------

        sessionManager = Alamofire.Session(configuration: configuration)

    }

}
