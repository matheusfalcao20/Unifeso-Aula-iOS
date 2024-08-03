//
//  StudentAPI.swift
//  Leitura_de_presenca
//
//  Created by Mohamad Lobo on 01/08/24.
//

import Foundation
import UIKit
import Alamofire

class StudentAPI: ObservableObject {
    
    fileprivate init() { }
    
    /* ******************************************************************************
     **
     **  MARK: List Lessons
     **
     ********************************************************************************/
    
    static func listLessons(callback: @escaping (ServerResponse) -> Void) {
        
        let newURL = API.host + API.listStudentLessons
        
        print("request - listLessons")
        print(newURL)
        
        let headers: HTTPHeaders = ["Authorization": "token \(LoggedUser.sharedInstance.token)"]
        
        print(headers)
        
        API.sharedInstance.sessionManager.request(newURL,
                                                  method: .get,
                                                  encoding: URLEncoding.default,
                                                  headers: headers
        ).responseJSON(completionHandler: { response in
            
            let resposta = ServerResponse()
            
            resposta.statusCode = response.response?.statusCode ?? 0
            
            print("response - listLessons")
            
            switch response.result {
                
            case let .success(value):
                
                let JSON = value as AnyObject
                
                print(JSON)
                
                if response.response?.statusCode == 200 {
                    
                    if let results = JSON as? [[String : Any]] {
                        
                        resposta.listStudentLessons = DAOListStudentLessons.transformJSONInArrayListStudentLessons(results as AnyObject)
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
                        
                    }
                }
                
            case let .failure(error):
                print(error)
                
            }
            
            resposta.success = false
            resposta.erroMessage = "Não foi possível carregar as aulas"
            callback(resposta)
            
        })
        
    }
    
    /* ******************************************************************************
     **
     **  MARK: Read Qr Code
     **
     ********************************************************************************/
    
    static func readQrCode(params : [String: Any], callback: @escaping (ServerResponse) -> Void) {
        
        let newURL = API.host + API.readQrCode
        
        let headers : HTTPHeaders = ["Authorization" : "token \(LoggedUser.sharedInstance.token)"]
        
        print("resquest - readQrCode")
        print(newURL)
        print(params)
        
        API.sharedInstance.sessionManager.request(newURL,
                                                  method: HTTPMethod.post,
                                                  parameters: params,
                                                  encoding: URLEncoding.default,
                                                  headers: headers
        ).responseJSON(completionHandler: { response in
            
            let resposta = ServerResponse()
            
            print("response - readQrCode")
            print(response.result)
            
            switch response.result {
                
            case let .success(value):
                resposta.statusCode = response.response?.statusCode ?? 0
                
                let JSON = value as AnyObject
                
                if response.response?.statusCode == 200 {
                    
                    resposta.success = true
                    callback(resposta)
                    return
                    
                }
                
            case let .failure(error):
                print(error)
                
            }
            
            resposta.success = false
            resposta.erroMessage = "Não foi possível adicionar uma nova aula"
            
            callback(resposta)
            
        })
        
    }
}
