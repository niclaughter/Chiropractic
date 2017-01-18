//
//  AccountController.swift
//  Chiropractic
//
//  Created by Nicholas Laughter on 1/18/17.
//  Copyright © 2017 Nicholas Laughter. All rights reserved.
//

import Foundation

class AccountController {
    
    static let shared = AccountController()
    
    func createAccount(withEmail email: String) {
        var account = Account(email: email)
        account.save()
    }
}
