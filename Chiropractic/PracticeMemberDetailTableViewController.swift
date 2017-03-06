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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}
