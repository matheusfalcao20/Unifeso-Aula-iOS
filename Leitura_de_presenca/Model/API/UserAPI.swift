//
//  UserAPI.swift
//  Aula2
//
//  Created by Mohamad Lobo on 12/07/24.
//

import Foundation
import UIKit
import Alamofire

class UserAPI: ObservableObject {
    
    fileprivate init() { }
    
    enum UserType {
        case aluno
        case professor
    }
    
    /* ******************************************************************************
     **
     **  MARK: Sign In
     **
     ********************************************************************************/
    
    static func signIn(params: [String: Any], userType: UserType, callback: @escaping (ServerResponse) -> Void) {
        
        let url: String
        switch userType {
        case .aluno:
            url = API.host + API.authStudent
        case .professor:
            url = API.host + API.authTeacher
        }
        
        print("request - signIn")
        print(url)
        print(params)
        
        API.sharedInstance.sessionManager.request(url,
                                                  method: .post,
                                                  parameters: params,
                                                  encoding: JSONEncoding.default)
        .responseJSON { responseJSON in
            
            let respostaRequisicao = ServerResponse()
            
            print("response - signIn")
            print(responseJSON.result)
            
            switch responseJSON.result {
            case let .success(value):
                respostaRequisicao.statusCode = responseJSON.response?.statusCode ?? 0
                
                let JSON = value as AnyObject
                
                if let token = JSON["token"] as? String {
                    print(token)
                    
                    let preferences = UserDefaults.standard
                    preferences.setValue(token, forKey: PreferenceKeys.token.rawValue)
                    
                    LoggedUser.sharedInstance.token = token
                    respostaRequisicao.success = true
                    callback(respostaRequisicao)
                    return
                }
                
            case let .failure(error):
                print(error)
            }
            
            respostaRequisicao.success = false
            respostaRequisicao.erroMessage = userType == .aluno ? "Matrícula e/ou senha incorretos" : "Email e/ou senha incorretos"
            
            callback(respostaRequisicao)
        }
    }
    
    /* ******************************************************************************
     **
     **  MARK: Get User
     **
     ********************************************************************************/
    
    static func getUser(callback: @escaping (ServerResponse) -> Void) {
        
        let newURL = API.host + API.getUser
        
        print("request - getUser")
        print(newURL)
        
        let headers: HTTPHeaders = ["Authorization": "token \(LoggedUser.sharedInstance.token)"]
        
        print(headers)
        
        API.sharedInstance.sessionManager.request(newURL,
                                                  method: .get,
                                                  encoding: URLEncoding.default,
                                                  headers: headers)
        .responseJSON { responseJSON in
            
            let respostaRequisicao = ServerResponse()
            
            print("response - getUser")
            print(responseJSON.result)
            
            switch responseJSON.result {
            case let .success(value):
                respostaRequisicao.statusCode = responseJSON.response?.statusCode ?? 0
                
                let JSON = value as AnyObject
                
                if let result = JSON as? [String: Any] {
                    
                    LoggedUser.sharedInstance.user = DAOUser.transformJSONInUser(result as AnyObject)
                    respostaRequisicao.success = true
                    callback(respostaRequisicao)
                    return
                    
                } else if let detail = JSON["detail"] as? String {
                    respostaRequisicao.success = false
                    respostaRequisicao.erroMessage = detail
                    callback(respostaRequisicao)
                    return
                } else {
                    respostaRequisicao.success = false
                    respostaRequisicao.erroMessage = "Não foi possível carregar as informações do usuário"
                    callback(respostaRequisicao)
                    return
                }
                
            case let .failure(error):
                print(error)
            }
            
            respostaRequisicao.success = false
            respostaRequisicao.erroMessage = "Não foi possível carregar as informações do usuário"
            callback(respostaRequisicao)
        }
    }
}

