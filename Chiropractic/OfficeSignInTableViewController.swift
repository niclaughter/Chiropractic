//
//  OfficeSignInTableViewController.swift
//  Chiropractic
//
//  Created by Nicholas Laughter on 1/23/17.
//  Copyright © 2017 Nicholas Laughter. All rights reserved.
//

import UIKit

class OfficeSignInTableViewController: UITableViewController {
    
    // MARK: - Outlets
    
    @IBOutlet var headerImageView: UIView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var kidsTextField: UITextField!
    @IBOutlet weak var adultOrChildSelector: UISegmentedControl!
    @IBOutlet weak var paymentTypeTextField: UITextField!
    @IBOutlet weak var signatureView: SignatureCaptureView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
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
