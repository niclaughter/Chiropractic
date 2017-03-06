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
    
    var practiceMember: PracticeMember? {
        didSet {
            if !isViewLoaded {
                loadView()
            }
            updateViews()
        }
    }
    
    func updateViews() {
        guard let practiceMember = practiceMember else { return }
        nameLabel.text = practiceMember.name
        kidsNamesLabel.text = !practiceMember.kids.isEmpty ? practiceMember.kids : "No kids"
        adultOrChildLabel.text = practiceMember.adultOrChild.rawValue
        paymentTypeLabel.text = practiceMember.paymentType.rawValue
        timeCheckedInLabel.text = dateFormatter.string(from: practiceMember.signedInDate)
    }
    
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        formatter.doesRelativeDateFormatting = true
        return formatter
    }()
}
