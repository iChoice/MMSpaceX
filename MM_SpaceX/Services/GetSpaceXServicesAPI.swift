//
//  GetSpaceXServicesAPI.swift
//  MMSpaceX
//
//  Created by Michael on 02/08/18.
//  Copyright © 2018 MM. All rights reserved.
//

import Foundation

class GetSpaceXServicesAPI {
    
    lazy var session = URLSession.shared

    func spaceFlightLaunchSearch  (year: String, startDate:String, endDate:String,
                                   completion: @escaping (_ resultData: Data?, Error?) -> Void ) {

        var urlString = ""
        
        if !(year == "") {
            // not empty year, use it.
            let urlStringYearSearch = "https://api.spacexdata.com/v2/launches?launch_year=" + year
            urlString = urlStringYearSearch
        } else {
            let urlStringDateRange = "https://api.spacexdata.com/v2/launches?start="+startDate+"&final="+endDate
            urlString = urlStringDateRange
        }

        let urlStringSpacesEncoded = urlString.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!        // Need to percent encode this for spaces
        let url = URL(string:  urlStringSpacesEncoded)
        let request = NSMutableURLRequest(url: url!)
        request.httpMethod = "GET"

        let task = session.dataTask(with: request as URLRequest, completionHandler: { (data: Data?, response: URLResponse?, error: Error?) in
            
            if let response = response {
                print(response)
            }
            
            if let error = error {
                print(error)
            }
            completion(data,error)
        })
        task.resume()
    }
}




