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
    
    static func signIn(params : [String: Any], callback: @escaping (ServerResponse) -> Void) {
        
        let newURL = API.auth
        
        print("resquest - signIn")
        print(newURL)
        print(params)
        
        API.sharedInstance.sessionManager.request(newURL,
                                                  method: HTTPMethod.post,
                                                  parameters: params,
                                                  encoding: URLEncoding.default)
        .responseJSON(completionHandler: { responseJSON in
            
            let respostaRequisicao = ServerResponse()
            
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
            respostaRequisicao.erroMessage = "Email e/ou senha incorretos"
            
            callback(respostaRequisicao)
        })
    }
    
    static func getUser(callback: @escaping (ServerResponse) -> Void) {
        
        let newURL = API.getUser
        
        print("resquest - getUser")
        print(newURL)
        
        let headers : HTTPHeaders = ["Authorization" : "token \(LoggedUser.sharedInstance.token)"]
        
        print(headers)
        
        API.sharedInstance.sessionManager.request(newURL,
                                                  method: HTTPMethod.get,
                                                  encoding: URLEncoding.default, headers: headers)
        .responseJSON(completionHandler: { responseJSON in
            
            let respostaRequisicao = ServerResponse()
            
            switch responseJSON.result {
                
            case let .success(value):
                respostaRequisicao.statusCode = responseJSON.response?.statusCode ?? 0
                
                let JSON = value as AnyObject
                
                if let result = JSON as? [String : Any] {
                    
                    LoggedUser.sharedInstance.user = DAOUser.transformJSONInUser(result as AnyObject)
                    respostaRequisicao.success = true
                    callback(respostaRequisicao)
                    return
                    
                } else {
                    
                    if let detail = JSON["detail"] as? String {
                        
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
                }
                
                case let .failure(error):
                    print(error)
                    
                }
                
                respostaRequisicao.success = false
                respostaRequisicao.erroMessage = "Não foi possível carregar as informações do usuário"
                callback(respostaRequisicao)
        })
    }
}
