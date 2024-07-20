import Alamofire
import SwiftUI

func list_classes(token: String, cb: @escaping ([StudentClassModel]) -> ()) {
    let request = AF.request("https://unifesoios.noclaf.com.br/core/list-my-student-lessons/", method: .get, headers: [.authorization(token)])
        .responseJSON {
            res in
            switch res.result {
            case .success(let data):
               print(res.response!.statusCode)
               if (res.response!.statusCode != 200) { return cb([]) }
                
                let json = data as! NSArray
//                let res = json["token"]! as! String
               
            case .failure(let error):
                return cb([])
            }
        }
    }
