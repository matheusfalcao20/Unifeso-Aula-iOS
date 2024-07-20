//
//  CreateAula.swift
//  Leitura_de_presenca
//
//  Created by 08-L05-D-054875 on 20/07/24.
//

import Foundation
//
//  ListClassrom.swift
//  Leitura_de_presenca
//
//  Created by 08-L05-D-054875 on 20/07/24.
//

import Foundation
import Alamofire


func createAulaAPI(token: String, id_teacher: Int) -> () {
    let request = AF.request("https://unifesoios.noclaf.com.br/core/create-lesson/", method: .post, parameters: ["class_teacher": id_teacher], headers: [.authorization(token)])
        .responseJSON {
            res in
            switch res.result {
            case .success(let data):
               print(res.response!.statusCode)
                if (res.response!.statusCode != 200) { return print(res.response?.statusCode) }
                
    
            case .failure(let error):
                print(error)
                return
            }
        }
    }

