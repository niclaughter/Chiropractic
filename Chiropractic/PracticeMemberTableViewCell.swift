//
//  PracticeMemberTableViewCell.swift
//  Chiropractic
//
//  Created by Nicholas Laughter on 1/17/17.
//  Copyright © 2017 Nicholas Laughter. All rights reserved.
//

import UIKit

class PracticeMemberTableViewCell: UITableViewCell {
    
    // MARK: - Properties

    var practiceMember: PracticeMember? {
        didSet {
            updateViews()
        }
    }
    
    @IBOutlet weak var practiceMemberNameLabel: UILabel!
    @IBOutlet weak var practiceMemberDetailLabel: UILabel!
    
    // MARK: - Helpers
    
    func updateViews() {
        guard let practiceMember = practiceMember else { return }
        practiceMemberNameLabel.text = practiceMember.name
        practiceMemberDetailLabel.text = !practiceMember.kids.isEmpty ? practiceMember.kids : practiceMember.adultOrChild.rawValue
    }
}
