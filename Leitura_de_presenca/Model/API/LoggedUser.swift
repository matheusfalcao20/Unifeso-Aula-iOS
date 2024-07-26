//
//  LoggedUser.swift
//  Aula2
//
//  Created by Mohamad Lobo on 12/07/24.
//
import Foundation
import UIKit

<<<<<<< HEAD
import Foundation
import UIKit

=======
>>>>>>> 4778bed (Helo iza)
class LoggedUser: ObservableObject {

    static let sharedInstance = LoggedUser()
    @Published var token : String = ""
    @Published var user : User!
    
    fileprivate init() {
        
    }
    
    static func clear() {
        LoggedUser.sharedInstance.token = ""
    }
    
}
