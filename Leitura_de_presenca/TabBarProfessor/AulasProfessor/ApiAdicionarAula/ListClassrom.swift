//
//  ListClassrom.swift
//  Leitura_de_presenca
//
//  Created by 08-L05-D-054875 on 20/07/24.
//

import Foundation
import Alamofire

struct ListClassesApi {
    var lesson_name: String
    var created_at: String
}

func getClassromAPI(token: String, cb: @escaping ([ClassRoom]) -> ()) {
    let request = AF.request("https://unifesoios.noclaf.com.br/core/list-lessons/", method: .get, headers: [.authorization(token)])
        .responseJSON {
            res in
            switch res.result {
            case .success(let data):
               print(res.response!.statusCode)
               if (res.response!.statusCode != 200) { return cb([]) }
                
                let json = data as! [NSDictionary]
                var res: [ClassRoom] = []
                
               
                
                for item in json {
                    res.append(
                        ClassRoom(
                            id: String(item["id"]as! Int),
                            code: item["code"] as! String,
                            created_at: item["created_at"] as! String,
                            lesson_name: item["lesson_name"] as! String
                        )
                    )
                }
                cb(res)
            case .failure(let error):
                return cb([])
            }
        }
    }

