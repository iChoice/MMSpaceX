//
//  ShowLaunchesInfoViewController.swift
//  MM_SpaceX
//
//  Created by Michael on 2/8/18.
//  Copyright © 2018 MM. All rights reserved.
//

import UIKit

class ShowLaunchesInfoViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    //MARK: Variables and Constants
    lazy var showLaunchesInfoVM = ShowLaunchesInfoViewModel()
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: View Controller Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
     }
    
    //MARK: IBActions
    
    
    //MARK: other


    //MARK: Tableview delegate functions
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.showLaunchesInfoVM.launches.missions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")! as! LaunchesTableViewCell
        let launch = self.showLaunchesInfoVM.launches.missions[indexPath.row]!

        cell.flightNumber.text = "Flight Number: \(String(describing: launch.flight_number))"
        cell.launchDate.text = "Launch Date:  \(String(describing: launch.launch_date))"
        cell.flightDescription.text = launch.details
        return cell
    }

}


class LaunchesTableViewCell : UITableViewCell {
    @IBOutlet weak var flightNumber: UILabel!
    @IBOutlet weak var launchDate: UILabel!
    @IBOutlet weak var flightDescription: UITextView!
}

