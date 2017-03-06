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
    var practiceMembersToDisplay = [PracticeMember]()

    override func viewDidLoad() {
        super.viewDidLoad()

        PracticeMemberController.shared.delegate = self
    }
    
    // MARK: - Table view data source and delegate
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return practiceMembersToDisplay.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.practiceMemberCellKey) as? PracticeMemberTableViewCell ?? PracticeMemberTableViewCell()
        let practiceMember = practiceMembersToDisplay[indexPath.row]
        cell.practiceMember = practiceMember
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // MARK: - UI Actions
    
    @IBAction func segmentedControlSegmentChanged(_ sender: Any) {
        switch timeframeSegmentedControl.selectedSegmentIndex {
        case 0:
            break
        case 1:
            break
        case 2:
            break
        case 3:
            break
        default:
            break
        }
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
            guard let identifier = practiceMember.identifier,
                let signatureImage = ImageController.shared.imagesDict[identifier] else { return }
            destinationViewController.signatureImage = signatureImage
        }
    }

    // MARK: - Helper Methods
    
    func getPracticeMembers(inCalendarUnit calendarUnit: NSCalendar.Unit) {
        if calendarUnit == .day {
            let members = PracticeMemberController.shared.practiceMembers
        }
    }
}
