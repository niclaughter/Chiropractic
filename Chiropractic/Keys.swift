//
//  Keys.swift
//  Chiropractic
//
//  Created by Nicholas Laughter on 1/16/17.
//  Copyright © 2017 Nicholas Laughter. All rights reserved.
//

import Foundation

struct Keys {
    
    /* Model Keys */
    // MARK: - PracticeMember Keys
    static let nameKey = "name"
    static let kidsKey = "kids"
    static let adultOrChildKey = "adultOrChild"
    static let paymentTypeKey = "paymentType"
    static let signatureDataKey = "signatureData"
    static let signedInDateKey = "signedInDate"
    static let identifierKey = "identifier"
    
    // MARK: - Account Keys
    static let emailKey = "email"
    static let accountTypeKey = "accountType"
    
    /* Firebase Keys */
    static let practiceMembersEndpoint = "practiceMembers"
    static let accountsEndpoint = "accounts"
    
    /* URL Strings */
    static let myChiro4KidsURLString = "http://mychiro4kids.com"
    
    /* Reuse Identifiers */
    static let practiceMemberCellKey = "practiceMemberCell"
    
    /* Segue Identifiers */
    static let toPracticeMemberDetailSegueKey = "toPracticeMemberDetailSegue"
    
    /* Storyboard IDs */
    static let iPadSignInViewControllerKey = "iPadSignInNavigationController"
    static let loginSignUpViewControllerKey = "loginSignUpViewController"
    static let webViewControllerKey = "webViewController"
    static let adminNavigationControllerKey = "adminNavigationController"
    
}

typealias JSONDictionary = [String: Any]
