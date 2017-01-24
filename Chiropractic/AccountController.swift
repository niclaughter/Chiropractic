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
    
    func fetchAccount(withIdentifier identifier: String, completion: @escaping (AccountType) -> Void) {
        let accountRef = FirebaseController.ref.child(Keys.accountsEndpoint).child(identifier)
        accountRef.observeSingleEvent(of: .value, with: { (data) in
            guard let accountDict = data.value as? [String: Any] else { return }
            guard let account = Account(dictionary: accountDict, identifier: identifier) else {
                completion(.user)
                return
            }
            completion(account.accountType)
        })
    }
}
