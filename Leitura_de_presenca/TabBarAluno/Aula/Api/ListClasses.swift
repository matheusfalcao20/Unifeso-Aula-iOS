import Alamofire
import SwiftUI

struct ListClassesApi {
    var lesson_name: String
    var created_at: String
}

func list_classes(token: String, cb: @escaping ([StudentClassModel]) -> ()) {
    let request = AF.request("https://unifesoios.noclaf.com.br/core/list-my-student-lessons/", method: .get, headers: [.authorization(token)])
        .responseJSON {
            res in
            switch res.result {
            case .success(let data):
               print(res.response!.statusCode)
               if (res.response!.statusCode != 200) { return cb([]) }
                
                let json = data as! [NSDictionary]
                var res: [StudentClassModel] = []
                
                for item in json {
                    res.append(StudentClassModel(title: item["lesson_name"] as! String, time: convert_time(item["created_at"] as! String), hasPresence: item["is_present"] as! Bool))
                }
                cb(res)
            case .failure(let error):
                return cb([])
            }
        }
    }
