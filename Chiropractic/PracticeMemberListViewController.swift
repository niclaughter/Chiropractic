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
    var practiceMembersToDisplay = [PracticeMember]() {
        didSet {
            practiceMemberListTableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        PracticeMemberController.shared.delegate = self
        practiceMemberListTableView.tableFooterView = UIView()
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
            getPracticeMembers(forTimeframe: .today)
        case 1:
            getPracticeMembers(forTimeframe: .yesterday)
        case 2:
            getPracticeMembers(forTimeframe: .week)
        case 3:
            getPracticeMembers(forTimeframe: .month)
        default:
            break
        }
    }
    
    @IBAction func printListButtonTapped(_ sender: Any) {
        presentComingSoonAlertController()
    }
    
    // MARK: - Practice Members Controller Delegate
    
    func practiceMembersUpdated() {
        DispatchQueue.main.async {
            if self.practiceMembersToDisplay.count == 0 {
                self.getPracticeMembers(forTimeframe: .today)
            }
            self.practiceMemberListTableView.reloadData()
        }
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constants.toPracticeMemberDetailSegueKey {
            guard let destinationViewController = segue.destination as? PracticeMemberDetailTableViewController,
                let indexPath = practiceMemberListTableView.indexPathForSelectedRow else { return }
            let practiceMember = practiceMembersToDisplay[indexPath.row]
            destinationViewController.practiceMember = practiceMember
            guard let identifier = practiceMember.identifier,
                let signatureImage = ImageController.shared.imagesDict[identifier] else { return }
            destinationViewController.signatureImage = signatureImage
        }
    }

    // MARK: - Helper Methods
    
    func getPracticeMembers(forTimeframe timeframe: Timeframe) {
        let today = Date()
        let calendar = Calendar.current
        switch timeframe {
        case .today:
            practiceMembersToDisplay = PracticeMemberController.shared.practiceMembers.filter { calendar.isDateInToday($0.signedInDate) }
        case .yesterday:
            practiceMembersToDisplay = PracticeMemberController.shared.practiceMembers.filter { calendar.isDateInYesterday($0.signedInDate) }
        case .week:
            practiceMembersToDisplay = PracticeMemberController.shared.practiceMembers.filter { calendar.isDate($0.signedInDate, equalTo: today, toGranularity: .weekOfMonth) }
        case .month:
            practiceMembersToDisplay = PracticeMemberController.shared.practiceMembers.filter { calendar.isDate($0.signedInDate, equalTo: today, toGranularity: .month) }
        }
    }
    
    func presentComingSoonAlertController() {
        let alertController = UIAlertController(title: "Soming Soon!", message: "This feature isn't ready yet, but will be available soon", preferredStyle: .alert)
        let dismissAction = UIAlertAction(title: "Dismiss", style: .default, handler: nil)
        alertController.addAction(dismissAction)
        present(alertController, animated: true, completion: nil)
    }
}
