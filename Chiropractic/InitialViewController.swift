//
//  InitialViewController.swift
//  Chiropractic
//
//  Created by Nicholas Laughter on 3/2/17.
//  Copyright © 2017 Nicholas Laughter. All rights reserved.
//

import UIKit
import FirebaseAuth

class InitialViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpAppUsage()
    }
    
    func setUpAppUsage() {
        navigationController?.navigationBar.isHidden = true
        
        if FIRAuth.auth()?.currentUser != nil {
            checkUserAgainstDatabase { (success, _) in
                if success,
                    let currentUser = FIRAuth.auth()?.currentUser {
                    self.setUpLoader(withTitle: "Fetching Profile")
                    AccountController.shared.fetchAccount(withIdentifier: currentUser.uid, completion: { (accountType) in
                        ViewTransitionManager.transitionToCorrectViewController(fromViewController: self, forAccountType: accountType)
                        LoaderView.hide()
                    })
                } else {
                    ViewTransitionManager.transitionToCorrectViewController(fromViewController: self, forAccountType: .initial)
                }
            }
        } else {
            ViewTransitionManager.transitionToCorrectViewController(fromViewController: self, forAccountType: .initial)
        }
    }
    
    func checkUserAgainstDatabase(_ completion: @escaping (_ success: Bool, _ error: NSError?) -> Void) {
        guard let currentUser = FIRAuth.auth()?.currentUser else { return }
        currentUser.getTokenForcingRefresh(true) { (idToken, error) in
            if let error = error {
                completion(false, error as NSError?)
                print(error.localizedDescription)
            } else {
                completion(true, nil)
            }
        }
    }
    
    // MARK: - Loader
    
    func setUpLoader(withTitle title: String) {
        var config = LoaderView.Config()
        config.size = 150
        config.spinnerColor = .softGray
        config.spinnerLineWidth = 3
        config.foregroundColor = .softBlack
        config.foregroundAlpha = 0.5
        LoaderView.setConfig(config: config)
        LoaderView.show(title: title, animated: true)
    }
}
