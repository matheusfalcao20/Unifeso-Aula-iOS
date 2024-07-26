
//  UserAPI.swift
//  Aula2
//  Created by Mohamad Lobo on 12/07/24.

<<<<<<< HEAD
=======

>>>>>>> 4778bed (Helo iza)
import Foundation
import UIKit
import Alamofire

<<<<<<< HEAD
class UserAPI: ObservableObject {
    
    fileprivate init() { }

    enum UserType {
        case aluno
        case professor
    }
    
    static func signIn(params: [String: Any], userType: UserType, callback: @escaping (ServerResponse) -> Void) {
        
        let url: String
        switch userType {
        case .aluno:
            url = API_Aluno.auth
        case .professor:
            url = API_Professor.auth
        }
        
        print("request - signIn")
        print(url)
        print(params)
        
        API_Aluno.sharedInstance.sessionManager.request(url,
                                                         method: .post,
                                                         parameters: params,
                                                         encoding: JSONEncoding.default)
            .responseJSON { responseJSON in
                
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
                respostaRequisicao.erroMessage = userType == .aluno ? "Matrícula e/ou senha incorretos" : "Email e/ou senha incorretos"
                
                callback(respostaRequisicao)
            }
    }

    
    static func getUser(callback: @escaping (ServerResponse) -> Void) {
        
        let newURLAluno = API_Aluno.getUser
        let newURLProfessor = API_Professor.getUser
        
        print("request - getUser")
        print(newURLAluno)
        print(newURLProfessor)
        
        let headers: HTTPHeaders = ["Authorization": "token \(LoggedUser.sharedInstance.token)"]
        
        print(headers)
        
        API_Professor.sharedInstance.sessionManager.request(newURLProfessor,
                                                            method: .get,
                                                            encoding: URLEncoding.default,
                                                            headers: headers)
            .responseJSON { responseJSON in
                
                let respostaRequisicao = ServerResponse()
                
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

=======
class UserAPI : ObservableObject {
    
    fileprivate init () {
        
    }
    
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
//                    preferences.setValue(token, forKey: PreferenceKeys.token.rawValue)
                    
                    
                    
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
>>>>>>> 4778bed (Helo iza)
