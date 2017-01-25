//
//  ViewTransitionManager.swift
//  Chiropractic
//
//  Created by Nicholas Laughter on 1/24/17.
//  Copyright © 2017 Nicholas Laughter. All rights reserved.
//

import UIKit

class ViewTransitionManager {
    
    static func transitionToCorrectViewController(fromViewController: UIViewController, forAccountType accountType: AccountType) {
        switch accountType {
        case .user:
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let viewController = storyboard.instantiateViewController(withIdentifier: Keys.webViewControllerKey)
            fromViewController.present(viewController, animated: true, completion: nil)
        case .admin:
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let viewController = storyboard.instantiateViewController(withIdentifier: Keys.adminNavigationControllerKey)
            fromViewController.present(viewController, animated: true, completion: nil)
        case .office:
            let storyboard = UIStoryboard(name: "iPad", bundle: nil)
            let viewController = storyboard.instantiateViewController(withIdentifier: Keys.iPadSignInViewControllerKey)
            fromViewController.present(viewController, animated: true, completion: nil)
        case .initial:
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let viewController = storyboard.instantiateViewController(withIdentifier: Keys.loginSignUpViewControllerKey)
            fromViewController.present(viewController, animated: true, completion: nil)
        }
    }
}
