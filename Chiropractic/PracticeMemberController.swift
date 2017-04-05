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
            for practiceMember in practiceMembers {
                ImageController.shared.fetchImage(forPracticeMember: practiceMember)
            }
        }
    }
    var delegate: PracticeMembersControllerDelegate?
    
    // MARK: - Functions
    
    init() {
        observePracticeMembers {
            NSLog("Practice members being observed.")
        }
    }
    
    func signInPracticeMember(withName name: String,
                              kids: String,
                              adultOrChild: AdultOrChild,
                              paymentType: PaymentType,
                              andIdentifier identifier: String,
                              completion: @escaping () -> Void = { _ in }) {
        var practiceMember = PracticeMember(name: name, kids: kids, adultOrChild: adultOrChild, paymentType: paymentType, identifier: identifier)
        practiceMember.save()
        completion()
    }
    
    func observePracticeMembers(completion: @escaping () -> Void = { _ in }) {
        defer { completion() }
        let practiceMembersRef = FirebaseController.databaseRef.child(.practiceMembersEndpoint)
        practiceMembersRef.observe(.value, with: { (snapshot) in
            guard let practiceMembersDict = snapshot.value as? [String: JSONDictionary] else { return }
            self.practiceMembers = practiceMembersDict.flatMap { PracticeMember(dictionary: $1, identifier: $0) }
        })
    }
}

protocol PracticeMembersControllerDelegate {
    func practiceMembersUpdated()
}
