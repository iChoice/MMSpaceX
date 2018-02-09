//
//  SpaceXLaunchSearchViewController.swift
//  MM_SpaceX
//
//  Created by Michael on 2/8/18.
//  Copyright © 2018 MM. All rights reserved.
//

import UIKit

class SpaceXLaunchSearchViewController: UIViewController, UITextFieldDelegate {

    var spaceXLaunchSearchVM = SpaceXLaunchSearchViewModel()
    @IBOutlet weak var year: UITextField!
    
    @IBOutlet weak var startDate: UITextField!
    @IBOutlet weak var endDate: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.endDate.text = ""
        self.startDate.text = ""
        self.year.text = ""
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    //MARK: IBAction
    
    @IBAction func searchButtonPressed(_ sender: UIButton) {

        // Make sure there is either a valid year, or dates entered.
        // In a real app I would use a date selector, but I ran out of time for this challenge
        guard self.year.text?.count == 4 || (self.startDate.text  != "" && self.endDate.text != "")  else {
            let alert = UIAlertController(title: "Please enter in a 4 digit year or a valid date range.", message: nil, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in }))
            self.present(alert, animated: true, completion: nil)            
            return
        }
    
        self.view.endEditing(true) // Get rid of the keyboard
        
        self.spaceXLaunchSearchVM.search(Year: self.year.text!, startDate: self.startDate.text!, endDate: self.endDate.text!) { (launches, error) in
            // I probably don't need to return 'launches' here, as I am putting it into the ViewModel and calling it there.
            // And if I had more time, I would trap for the error and report if there is something wrong.
            if error == nil {
                DispatchQueue.main.async {
                    self.performSegue(withIdentifier: "Show Launches", sender: self)
                }
            }
        }
    }
    
    @IBAction func dateEntered(_ sender: UITextField) {
        self.year.text = "" // Clear out year, cannot have both date range and year
    }
    
    @IBAction func yearEntered(_ sender: UITextField) {
        self.startDate.text = ""
        self.endDate.text = ""
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Show Launches" {
            let destVC = segue.destination as! ShowLaunchesInfoViewController
            destVC.showLaunchesInfoVM = ShowLaunchesInfoViewModel()
            destVC.showLaunchesInfoVM.launches = self.spaceXLaunchSearchVM.launches
        }
    }

}
