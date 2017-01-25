//
//  ViewTransitionManager.swift
//  Chiropractic
//
//  Created by Nicholas Laughter on 1/24/17.
//  Copyright © 2017 Nicholas Laughter. All rights reserved.
//

import UIKit

class ViewTransitionManager {
    
    static func transitionToCorrectViewController(forAccountType accountType: AccountType) {
        switch accountType {
        case .user:
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let viewController = storyboard.instantiateViewController(withIdentifier: Keys.webViewControllerKey)
            guard let optionalWindow = UIApplication.shared.delegate?.window,
                let window = optionalWindow,
                let rootViewController = window.rootViewController else { return }
            rootViewController.present(viewController, animated: true, completion: nil)
        case .admin:
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let viewController = storyboard.instantiateViewController(withIdentifier: Keys.adminNavigationControllerKey)
            guard let optionalWindow = UIApplication.shared.delegate?.window,
                let window = optionalWindow,
                let rootViewController = window.rootViewController else { return }
            rootViewController.present(viewController, animated: true, completion: nil)
        case .office:
            let storyboard = UIStoryboard(name: "iPad", bundle: nil)
            let viewController = storyboard.instantiateViewController(withIdentifier: Keys.iPadSignInViewControllerKey)
            guard let optionalWindow = UIApplication.shared.delegate?.window,
                let window = optionalWindow,
                let rootViewController = window.rootViewController else { return }
            rootViewController.present(viewController, animated: true, completion: nil)
        case .initial:
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let viewController = storyboard.instantiateViewController(withIdentifier: Keys.loginSignUpViewControllerKey)
            guard let optionalWindow = UIApplication.shared.delegate?.window,
                let window = optionalWindow,
                let rootViewController = window.rootViewController else { return }
            rootViewController.present(viewController, animated: true, completion: nil)
        }
    }
}
