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

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constants.toPracticeMemberDetailSegueKey {
            guard let destinationViewController = segue.destination as? PracticeMemberDetailTableViewController,
                let indexPath = practiceMemberListTableView.indexPathForSelectedRow else { return }
            let practiceMember = PracticeMemberController.shared.practiceMembers[indexPath.row]
            destinationViewController.practiceMember = practiceMember
        }
    }

}
