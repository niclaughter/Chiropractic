//
//  OfficeSignInTableViewController.swift
//  Chiropractic
//
//  Created by Nicholas Laughter on 1/23/17.
//  Copyright © 2017 Nicholas Laughter. All rights reserved.
//

import UIKit

class OfficeSignInTableViewController: UITableViewController, SignatureCaptureDelegate {
    
    // MARK: - Outlets
    
    @IBOutlet var headerImageView: UIView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var kidsTextField: UITextField!
    @IBOutlet weak var adultOrChildSelector: UISegmentedControl!
    @IBOutlet weak var paymentTypeTextField: UITextField!
    @IBOutlet weak var signatureView: SignatureCaptureView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        signatureView.delegate = self
        
    }
    
    // MARK: - SignatureCaptureDelegate
    
    func startedDrawing() {
        NSLog("Started drawing")
        tableView.isScrollEnabled = false
    }
    
    func finishedDrawing() {
        NSLog("Finished drawing")
        tableView.isScrollEnabled = true
    }
}
