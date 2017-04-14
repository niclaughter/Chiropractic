//
//  PracticeMemberDetailTableViewController.swift
//  Chiropractic
//
//  Created by Nicholas Laughter on 3/1/17.
//  Copyright © 2017 Nicholas Laughter. All rights reserved.
//

import UIKit

class PracticeMemberDetailTableViewController: UITableViewController {
    
    // MARK: - Properties
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var kidsNamesLabel: UILabel!
    @IBOutlet weak var adultOrChildLabel: UILabel!
    @IBOutlet weak var paymentTypeLabel: UILabel!
    @IBOutlet weak var timeCheckedInLabel: UILabel!
    @IBOutlet weak var signatureImageView: UIImageView!
    
    let dateHelper = DateHelper()
    
    var practiceMember: PracticeMember? {
        didSet {
            if !isViewLoaded {
                loadView()
            }
            updateViewsForPracticeMember()
        }
    }
    
    var signatureImage: UIImage? {
        didSet {
            if !isViewLoaded {
                loadView()
            }
            updateViewForSignatureImage()
        }
    }
    
    func updateViewsForPracticeMember() {
        guard let practiceMember = practiceMember else { return }
        nameLabel.text = practiceMember.name
        kidsNamesLabel.text = !practiceMember.kids.isEmpty ? practiceMember.kids : "No kids"
        adultOrChildLabel.text = practiceMember.adultOrChild.rawValue
        paymentTypeLabel.text = practiceMember.paymentType.rawValue
        timeCheckedInLabel.text = dateHelper.dateFormatter.string(from: practiceMember.signedInDate)
    }
    
    func updateViewForSignatureImage() {
        guard let signatureImage = signatureImage else { return }
        signatureImageView.image = signatureImage
    }
}
