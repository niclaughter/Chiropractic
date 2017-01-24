//
//  AccountController.swift
//  Chiropractic
//
//  Created by Nicholas Laughter on 1/18/17.
//  Copyright © 2017 Nicholas Laughter. All rights reserved.
//

import Foundation
import Firebase

class AccountController {
    
    static let shared = AccountController()
    
    var account: Account?
    
    func createAccount(withEmail email: String, andIdentifier identifier: String) {
        var account = Account(email: email, identifier: identifier)
        account.save()
    }
    
    func setAccount(withIdentifier identifier: String) {
        
    }
}
