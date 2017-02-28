//
//  OfficeSignInTableViewController.swift
//  Chiropractic
//
//  Created by Nicholas Laughter on 1/23/17.
//  Copyright © 2017 Nicholas Laughter. All rights reserved.
//

import UIKit

class OfficeSignInTableViewController: UITableViewController, SignatureCaptureDelegate, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    
    // MARK: - Outlets
    
    @IBOutlet var headerImageView: UIView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var kidsTextField: UITextField!
    @IBOutlet weak var adultOrChildSelector: UISegmentedControl!
    @IBOutlet weak var paymentTypeTextField: UITextField!
    @IBOutlet weak var signatureView: SignatureCaptureView!
    @IBOutlet weak var signInButton: UIBarButtonItem!    
    @IBOutlet weak var clearSignatureButton: UIButton!
    @IBOutlet weak var paymentTypePickerView: UIPickerView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpViews()
    }
    
    // MARK: - User Actions
    
    @IBAction func signInButtonTapped(_ sender: Any) {
        
    }
    
    @IBAction func clearSignatureButtonTapped(_ sender: Any) {
        signatureView.clear()
    }
    
    // MARK: - SignatureCaptureDelegate
    
    func startedDrawing() {
        tableView.isScrollEnabled = false
    }
    
    func finishedDrawing() {
        NSLog("Finished drawing")
    }
    
    // MARK: - UITableView Delegate
    
    override func becomeFirstResponder() -> Bool {
        super.becomeFirstResponder()
        
        tableView.isScrollEnabled = true
        return true
    }
    
    override func resignFirstResponder() -> Bool {
        super.resignFirstResponder()
        
        tableView.isScrollEnabled = false
        return true
    }
    
    // MARK: - UIPickerView DataSource/Delegate
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch row {
        case 0:
            return PaymentType.wellness.rawValue
        case 1:
            return PaymentType.cash.rawValue
        case 2:
            return PaymentType.hsa.rawValue
        case 3:
            return PaymentType.personalInjury.rawValue
        case 4:
            return PaymentType.insurance.rawValue
        default:
            return ""
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch row {
        case 0:
            paymentTypeTextField.text = PaymentType.wellness.rawValue
        case 1:
            paymentTypeTextField.text = PaymentType.cash.rawValue
        case 2:
            paymentTypeTextField.text = PaymentType.hsa.rawValue
        case 3:
            paymentTypeTextField.text = PaymentType.personalInjury.rawValue
        case 4:
            paymentTypeTextField.text = PaymentType.insurance.rawValue
        default:
            paymentTypeTextField.text = ""
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return PaymentType.count
    }
    
    // MARK: - UITextFieldDelegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case nameTextField:
            kidsTextField.becomeFirstResponder()
        case kidsTextField:
            textField.resignFirstResponder()
        case paymentTypeTextField:
            textField.resignFirstResponder()
        default:
            break
        }
        return true
    }
    
    // MARK: - Helper Methods
    
    func setUpViews() {
        paymentTypeTextField.inputView = paymentTypePickerView
        
        signatureView.delegate = self
        tableView.isScrollEnabled = false
        
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor(red: 76/255, green: 217/255, blue: 100/255, alpha: 1)
        toolBar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(donePicker))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolBar.setItems([spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        paymentTypeTextField.inputAccessoryView = toolBar
    }
    
    @objc func donePicker() {
        paymentTypeTextField.resignFirstResponder()
    }
    
    func signInPracticeMember() {
        guard let name = nameTextField.text,
            let kids = kidsTextField.text else { return }
        
    }
}
