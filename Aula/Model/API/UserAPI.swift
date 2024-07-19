//
//  UserAPI.swift
//  Aula2
//
//  Created by Mohamad Lobo on 12/07/24.
//

import Foundation
import UIKit
import Alamofire

class UserAPI : ObservableObject {
    
    fileprivate init () {
        
    }
    
    
    /* *********************************************************************************
     **
     **  MARK: Login
     **
     ***********************************************************************************/
    
    static func signIn(params : [String: Any], callback: @escaping (ServerResponse) -> Void) {
        
        let newURL = API.host + API.auth
        
        print("resquest - signIn")
        print(newURL)
        print(params)
        
        API.sharedInstance.sessionManager.request(newURL,
                                                  method: HTTPMethod.post,
                                                  parameters: params,
                                                  encoding: URLEncoding.default,
                                                  headers: nil
        ).responseJSON(completionHandler: { response in
            
            let resposta = ServerResponse()
            
            print("response - signIn")
            print(response.result)
            
            switch response.result {
                
            case let .success(value):
                resposta.statusCode = response.response?.statusCode ?? 0
                
                let JSON = value as AnyObject
                
                if response.response?.statusCode == 200, let token = JSON["token"] as? String {
                    print(token)
                    
                    let preferences = UserDefaults.standard
                    preferences.setValue(token, forKey: PreferenceKeys.token.rawValue)
                    
                    
                    
                    LoggedUser.sharedInstance.token = token
                    resposta.success = true
                    callback(resposta)
                    return
                    
                }
                
            case let .failure(error):
                print(error)
                
            }
            
            resposta.success = false
            resposta.erroMessage = "Email e/ou senha incorretos"
            
            callback(resposta)
            
        })
        
    }
    
    /* *********************************************************************************
     **
     **  MARK: Get User
     **
     ***********************************************************************************/
    
    static func getUser(callback: @escaping (ServerResponse) -> Void) {
        
        let newURL = API.host + API.getUser
        
        print("resquest - getUser")
        print(newURL)
        
        let headers : HTTPHeaders = ["Authorization" : "token \(LoggedUser.sharedInstance.token)"]
        
        print(headers)
        
        API.sharedInstance.sessionManager.request(newURL,
                                                  method: HTTPMethod.get,
                                                  parameters: nil,
                                                  encoding: URLEncoding.default,
                                                  headers: headers
        ).responseJSON(completionHandler: { response in
            
            let resposta = ServerResponse()
            
            print("response - getUser")
            print(response.result)
            
            switch response.result {
                
            case let .success(value):
                resposta.statusCode = response.response?.statusCode ?? 0
                
                let JSON = value as AnyObject
                
                if response.response?.statusCode == 200 {
                    
                    if let result = JSON as? [String : Any] {
                        
                        LoggedUser.sharedInstance.user = DAOUser.transformJSONInUser(result as AnyObject)
                        resposta.success = true
                        callback(resposta)
                        return
                        
                    }
                    
                } else {
                    
                    if let detail = JSON["detail"] as? String {
                        
                        resposta.success = false
                        resposta.erroMessage = detail
                        callback(resposta)
                        return
                        
                    } else {
                        
                        resposta.success = false
                        resposta.erroMessage = "Não foi possível carregar as informações do usuário"
                        callback(resposta)
                        return
                    }
                    
                }
                
            case let .failure(error):
                print(error)
                
            }
            
            resposta.success = false
            resposta.erroMessage = "Não foi possível carregar as informações do usuário"
            callback(resposta)
            
        })
        
    }
}
