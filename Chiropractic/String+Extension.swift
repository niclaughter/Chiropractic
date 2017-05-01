//
//  String+Extension.swift
//  Chiropractic
//
//  Created by Nicholas Laughter on 1/14/17.
//  Copyright © 2017 Nicholas Laughter. All rights reserved.
//

import Foundation

extension String {
    func capitalizingFirstLetter() -> String {
        let first = String(characters.prefix(1)).capitalized
        let other = String(characters.dropFirst())
        return first + other
    }
    
    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
    
    /* Model Keys */
    // MARK: - PracticeMember Keys
    static var nameKey: String { get { return "Q5Vr7pXuV6Xjkpzq" } }
    static var kidsKey: String { get { return "bT5utAJVMU5teX6x" } }
    static var adultOrChildKey: String { get { return "sE37qNqw7GnMqYsL" } }
    static var paymentTypeKey: String { get { return "dMUTFdtNC2bGAmkZ" } }
    static var signatureDataStringKey: String { get { return "xDqk9MgCTjrrHg9w" } }
    static var signedInDateKey: String { get { return "aVqpJm84rfVwK4Qu" } }
    static var identifierKey: String { get { return "identifier" } }
    static var signatureDownloadURLKey: String { get { return "Cdgws8ZBjD24Zgbz" } }
    
    // MARK: - Account Keys
    static var emailKey: String { get { return "email" } }
    static var accountTypeKey: String { get { return "accountType" } }
    
    /* Firebase Keys */
    static var practiceMembersEndpoint: String { get { return "practiceMembers" } }
    static var accountsEndpoint: String { get { return "accounts" } }
    static var imagesEndpoint: String { get { return "images" } }
    static var signaturesEndpoint: String { get { return "signatures" } }
    
    /* URL Strings */
    static var myChiro4KidsURLString: String { get { return "http://mychiro4kids.com" } }
    
    /* Reuse Identifiers */
    static var practiceMemberCellKey: String { get { return "practiceMemberCell" } }
    
    /* Segue Identifiers */
    static var toPracticeMemberDetailSegueKey: String { get { return "toPracticeMemberDetailSegue" } }
    
    /* Storyboard IDs */
    static var iPadSignInViewControllerKey: String { get { return "iPadSignInNavigationController" } }
    static var loginSignUpViewControllerKey: String { get { return "loginSignUpViewController" } }
    static var webViewControllerKey: String { get { return "webViewController" } }
    static var adminNavigationControllerKey: String { get { return "adminNavigationController" } }
    
    /* User-Facing String Keys */
    static var timestampDisplayKey: String { get { return "Timestamp" } }
    static var nameDisplayKey: String { get { return "Name" } }
    static var kidsDisplayKey: String { get { return "Kids" } }
    static var ageDisplayKey: String { get { return "Age" } }
    static var paymentTypeDisplayKey: String { get { return "Payment Type" } }
    static var signatureDisplayKey: String { get { return "Signature" } }
    
    /* Encryption Key */
    static var encryptionKey: String { get { return "F16977903F6F89C53FE94F22862F58E7D170F942DE356DCBD6C34F626CBF9C64" } }
}
