//
//  PracticeMemberListViewController.swift
//  Chiropractic
//
//  Created by Nicholas Laughter on 1/17/17.
//  Copyright © 2017 Nicholas Laughter. All rights reserved.
//

import UIKit
import Firebase

class PracticeMemberListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, PracticeMembersControllerDelegate {
    
    // MARK: - Properties
    
    @IBOutlet weak var timeframeSegmentedControl: UISegmentedControl!
    @IBOutlet weak var practiceMemberListTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        PracticeMemberController.shared.delegate = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return PracticeMemberController.shared.practiceMembers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.practiceMemberCellKey) as? PracticeMemberTableViewCell ?? PracticeMemberTableViewCell()
        let practiceMember = PracticeMemberController.shared.practiceMembers[indexPath.row]
        cell.practiceMember = practiceMember
        return cell
    }
    
    @IBAction func segmentedControlSegmentChanged(_ sender: Any) {
        
    }
    
    @IBAction func printListButtonTapped(_ sender: Any) {
    }
    
    // MARK: - Practice Members Controller Delegate
    
    func practiceMembersUpdated() {
        DispatchQueue.main.async {
            self.practiceMemberListTableView.reloadData()
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
