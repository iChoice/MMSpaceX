//
//  ShowLaunchesInfoViewModel.swift
//  MM_SpaceX
//
//  Created by Michael on 2/8/18.
//  Copyright © 2018 MM. All rights reserved.
//

import Foundation
import UIKit

class ShowLaunchesInfoViewModel {
    var launches = Launches()
    lazy var session = URLSession.shared
    
    
    func getImageFromURL (urlStr: String,
                          completion: @escaping (_ resultData: Data?, Error?) -> Void ) {
        
        if let url = URL(string:  urlStr) {
            let request =  NSMutableURLRequest(url: url)
            request.httpMethod = "GET"
            
            let task = session.dataTask(with: request as URLRequest, completionHandler:
            { (data: Data?, response: URLResponse?, error: Error?) in
                if let response = response {
                    print(response)
                }
                if let error = error {
                    print(error)
                }
                completion(data,error)
            })
            task.resume()
        } else {
            completion(nil,nil)
        }
    }

    func cleanUpLaunchDate (dateStr:String) -> String {
        let cleanDateStr = dateStr[0...9]
        return cleanDateStr
    }
}

// Swift uses character sets which makes it harder to get a substring from a normal set of characters.  This does it for us, by adding an
// extension to String.
extension String {
    subscript (bounds: CountableClosedRange<Int>) -> String {
        let start = index(startIndex, offsetBy: bounds.lowerBound)
        let end = index(startIndex, offsetBy: bounds.upperBound)
        return String(self[start...end])
    }
    
    subscript (bounds: CountableRange<Int>) -> String {
        let start = index(startIndex, offsetBy: bounds.lowerBound)
        let end = index(startIndex, offsetBy: bounds.upperBound)
        return String(self[start..<end])
    }
}
