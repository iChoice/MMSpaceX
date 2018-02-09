//
//  Launch.swift
//  MM_SpaceX
//
//  Created by Michael on 2/8/18.
//  Copyright © 2018 MM. All rights reserved.
//

import Foundation

class Launch {
    var flight_number:Int
    var launch_year: String
    var launch_date: String
    var details: String
    
    
    init?(json: [String:Any]) {
        // print("json:\(json)")
        
        guard let flight_number = json["flight_number"] as? Int,
        let launch_year = json["launch_year"] as? String,
        let launch_date = json["launch_date_local"] as? String,
        let details = json["details"] as? String
        else {
            return nil
        }

        self.flight_number = flight_number
        self.launch_year = launch_year
        self.launch_date = launch_date
        self.details  = details
    }
}
