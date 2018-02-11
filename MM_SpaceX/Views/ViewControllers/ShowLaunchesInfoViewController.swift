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

        cell.rocketName.text = launch.rocket_name
        let currentCellFlightNumber = "\(String(describing: launch.flight_number))"
        cell.flightNumber.text = currentCellFlightNumber
        cell.launchDate.text = "\(String(describing:self.showLaunchesInfoVM.cleanUpLaunchDate(dateStr: launch.launch_date)))"
        cell.flightDescription.text = launch.details
        
        // Get the mission patch image from the web.
        // Given more time I would store this locally so that the scroll would be better and smoother.
        if let missionPathURL = launch.links["mission_patch"] {
            let missionPathURLHttps = missionPathURL.replacingOccurrences(of:"http", with: "https")
            print("Image URL STR: \(missionPathURLHttps)")
            self.showLaunchesInfoVM.getImageFromURL(urlStr: missionPathURLHttps) { (imageData, error) in
                if let bookImage = imageData {
                    DispatchQueue.main.async {
                        if cell.flightNumber.text == currentCellFlightNumber { // Make sure we are on the same cell when the image finally downloads (cell didn't get reused).
                            cell.missionPatch.image = UIImage(data:bookImage)
                            cell.layoutSubviews()
                        } // if cell.flightNumber.text
                    } // DispatchQueue.main
                } // let bookImage ...
            }//  getImageFromURL ...
        } // if missionPathURL ...
        return cell
    } // func tableView ... cellForRowAt
    
    
    
    
}



class LaunchesTableViewCell : UITableViewCell {
    
    @IBOutlet weak var missionPatch: UIImageView!
    @IBOutlet weak var rocketName: UILabel!
    @IBOutlet weak var flightNumber: UILabel!
    @IBOutlet weak var launchDate: UILabel!
    @IBOutlet weak var flightDescription: UITextView!
}

