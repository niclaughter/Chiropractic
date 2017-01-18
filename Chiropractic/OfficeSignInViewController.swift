//
//  OfficeSignInViewController.swift
//  Chiropractic
//
//  Created by Nicholas Laughter on 1/16/17.
//  Copyright © 2017 Nicholas Laughter. All rights reserved.
//

import UIKit

class OfficeSignInViewController: UIViewController {
    
    // MARK: - Properties
    
    @IBOutlet var headerImageView: UIView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var kidsTextField: UITextField!
    @IBOutlet weak var adultOrChildSelector: UISegmentedControl!
    @IBOutlet weak var paymentTypeTextField: UITextField!
    @IBOutlet weak var signatureView: SignatureCaptureView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    
}
