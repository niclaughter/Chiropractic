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
        navigationController?.navigationBar.isHidden = true
    }
    
    func setUpAppUsage() {
        if let currentUser = FIRAuth.auth()?.currentUser {
            setUpLoader(withTitle: "Fetching Profile")
            AccountController.shared.fetchAccount(withIdentifier: currentUser.uid, completion: { (accountType) in
                ViewTransitionManager.transitionToCorrectViewController(fromViewController: self, forAccountType: accountType)
                LoaderView.hide()
            })
        } else {
            ViewTransitionManager.transitionToCorrectViewController(fromViewController: self, forAccountType: .initial)
        }
    }
    
    // MARK: - Loader
    
    func setUpLoader(withTitle title: String) {
        var config = LoaderView.Config()
        config.size = 150
        config.spinnerColor = .cyan
        config.spinnerLineWidth = 3
        config.foregroundColor = .black
        config.foregroundAlpha = 0.5
        LoaderView.setConfig(config: config)
        LoaderView.show(title: title, animated: true)
    }
}
