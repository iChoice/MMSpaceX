//
//  SpaceXLaunchSearchViewModel.swift
//  MM_SpaceX
//
//  Created by Michael on 2/8/18.
//  Copyright © 2018 MM. All rights reserved.
//

import Foundation

class SpaceXLaunchSearchViewModel {
    lazy var getSpaceXServicesApi = GetSpaceXServicesAPI()
    var launches = Launches()
    
    func search (Year year:String, startDate: String, endDate: String,   completionHandler: @escaping (Launches, Error?) -> Void) {
        self.launches = Launches() // clear it out so that we can get new results without the old ones
        self.getSpaceXServicesApi.spaceFlightLaunchSearch(year:year, startDate: startDate, endDate: endDate ) { (searchResults, error) in
            if let sResults = searchResults {
                if let launchesJSON = try? JSONSerialization.jsonObject(with: sResults, options: .allowFragments) as! [[String: Any]] {
                    self.launches.missions = [Launch?]()
                    for launchJSON in launchesJSON {
                        if let launch = Launch(json: launchJSON) {
                            print("Launch JSON: \(launchJSON)")
                            self.launches.missions.append(launch)
                        }
                    }
                    
                    completionHandler(self.launches, error)
                }
            }
        }
    }
}
