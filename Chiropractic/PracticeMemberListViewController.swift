//
//  PracticeMemberListViewController.swift
//  Chiropractic
//
//  Created by Nicholas Laughter on 1/17/17.
//  Copyright © 2017 Nicholas Laughter. All rights reserved.
//

import UIKit
import Firebase

class PracticeMemberListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        <#code#>
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
    
    // MARK: - Handle account types
    
    func showViewControllerForAccountType() {
        guard let currentUser = FIRAuth.auth()?.currentUser else {
            let storyboard = UIStoryboard(name: "iPad", bundle: nil)
            let viewController = storyboard.instantiateViewController(withIdentifier: Keys.loginSignUpSceneKey)
            present(viewController, animated: true, completion: nil)
        }
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
