//
//  Account.swift
//  Chiropractic
//
//  Created by Nicholas Laughter on 1/18/17.
//  Copyright © 2017 Nicholas Laughter. All rights reserved.
//

import Foundation

struct Account: FirebaseType {
    
    let email: String
    let accountType: AccountType
    var identifier: String?
    
    var endpoint: String = Constants.accountsEndpoint
    
    var dictionaryCopy: [String : Any] {
        return [
            Constants.emailKey: email,
            Constants.accountTypeKey: accountType.rawValue
        ]
    }
    
    init(email: String, accountType: AccountType = .user, identifier: String = UUID().uuidString) {
        self.email = email
        self.accountType = accountType
        self.identifier = identifier
    }
    
    init?(dictionary: [String : Any], identifier: String) {
        guard let email = dictionary[Constants.emailKey] as? String,
            let accountTypeString = dictionary[Constants.accountTypeKey] as? String else { return nil }
        self.identifier = identifier
        self.email = email
        switch accountTypeString {
        case AccountType.admin.rawValue:
            self.accountType = .admin
        case AccountType.office.rawValue:
            self.accountType = .office
        default:
            self.accountType = .user
        }
    }
}
