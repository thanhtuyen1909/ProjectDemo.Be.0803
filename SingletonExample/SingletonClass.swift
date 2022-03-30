//
//  SingletonClass.swift
//  SingletonExample
//
//  Created by tuyen.quach on 24/03/2022.
//

import Foundation

class SingletonClass {
    static let shared = SingletonClass()
    
    var sharedUser = UserObject()
    var locationGranted: Bool?
    
    private init() {
        
    }
    
    func requestForUser() -> UserObject {
        return self.sharedUser
    }
}

class UserObject {
    var fname = "Tuyen"
    var lname = "Quachhhhh"
}
