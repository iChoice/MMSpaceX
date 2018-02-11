//
//  Launch.swift
//  MM_SpaceX
//
//  Created by Michael on 2/8/18.
//  Copyright © 2018 MM. All rights reserved.
//

import Foundation

class Launch {
    var rocket_name:String
    var flight_number:Int
    var launch_year: String
    var launch_date: String
    var details: String
    var launch_site:[String:Any]
    var success:Bool
    var links: [String:String]
    
    
    init?(json: [String:Any]) {
 
        guard
            let flight_number = json["flight_number"] as? Int,
            let launch_year = json["launch_year"] as? String,
            let launch_date = json["launch_date_local"] as? String,
            let details = json["details"] as? String
        else {
            print("+++++++++++++++++++++++++++++++++++++\nLaunch json: \(json)\n++++++++++++++++++++++++++++++++")
            return nil
        }
        
        self.flight_number = flight_number
        self.launch_year = launch_year
        self.launch_date = launch_date
        self.details  = details
        self.success = json["launch_success"] as! Bool

        if let rocket = json["rocket"] as? [String:Any] {
                self.rocket_name = rocket["rocket_name"] as! String // I am assuming if they pass a 'Rocket' group, it will have a name
            } else {
                self.rocket_name = ""
            }

        if let links = json["links"] as? [String:String] {
            self.links = links
        } else {
            self.links = [:]
        }
        
        self.launch_site = [:]
        if let lsite = json["launch_site"] as? [String:Any] {
            self.launch_site = lsite
        }
    }
}

