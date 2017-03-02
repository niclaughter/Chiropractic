//
//  PracticeMemberController.swift
//  Chiropractic
//
//  Created by Nicholas Laughter on 1/18/17.
//  Copyright © 2017 Nicholas Laughter. All rights reserved.
//

import Foundation
import UIKit

class PracticeMemberController {
    
    static let shared = PracticeMemberController()
    var practiceMembers = [PracticeMember]() {
        didSet {
            delegate?.practiceMembersUpdated()
        }
    }
    var delegate: PracticeMembersControllerDelegate?
    
    func getMembersSignedIn(sineDate date: Date) -> [PracticeMember] {
        
        // TODO: - Implement and replace return
        return [PracticeMember]()
    }
    
    func signInPracticeMember(withName name: String,
                              kids: String,
                              adultOrChild: AdultOrChild,
                              paymentType: PaymentType,
                              andSignature signatureImage: UIImage,
                              completion: @escaping () -> Void = { _ in }) {
        let practiceMemberIdentifier = FirebaseController.ref.child(Constants.practiceMembersEndpoint).childByAutoId().key
        var practiceMember = PracticeMember(name: name, kids: kids, adultOrChild: adultOrChild, paymentType: paymentType, signatureImage: signatureImage, identifier: practiceMemberIdentifier)
        practiceMember.save()
        completion()
    }
    
    func observePracticeMembers(completion: @escaping () -> Void = { _ in }) {
        defer { completion() }
        let practiceMembersRef = FirebaseController.ref.child(Constants.practiceMembersEndpoint)
        practiceMembersRef.observe(.value, with: { (snapshot) in
            guard let practiceMembersDict = snapshot.value as? [String: JSONDictionary] else { return }
            self.practiceMembers = practiceMembersDict.flatMap { PracticeMember(dictionary: $1, identifier: $0) }
        })
    }
}

protocol PracticeMembersControllerDelegate {
    func practiceMembersUpdated()
}
