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
    @IBOutlet weak var signInButton: UIBarButtonItem!    
    @IBOutlet weak var clearSignatureButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        signatureView.delegate = self        
        tableView.isScrollEnabled = false
    }
    
    // MARK: - User Actions
    
    @IBAction func signInButtonTapped(_ sender: Any) {
        
    }
    
    @IBAction func clearSignatureButtonTapped(_ sender: Any) {
        signatureView.clear()
    }
    
    // MARK: - SignatureCaptureDelegate
    
    func startedDrawing() {
        NSLog("Started drawing")
    }
    
    func finishedDrawing() {
        NSLog("Finished drawing")
    }
    
    // MARK: - Helper Methods
    
    func signInPracticeMember() {
        guard let name = nameTextField.text,
            let kids = kidsTextField.text else { return }
        
    }
}
