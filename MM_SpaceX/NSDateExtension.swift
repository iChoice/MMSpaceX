//
//  NSDateExtension.swift
//  MM_SpaceX
//
//  Created by Michael on 2/9/18.
//  Copyright © 2018 MM. All rights reserved.
//
//
// Updates the Date class to include only date and time strings, or date, time and seconds.

import Foundation

extension Date{
    
    static func dateAndTimeString(_ dDate: Date) -> String {
        let format = DateFormatter()
        format.dateFormat = "MM/dd/yyyy   HH:mm a"
        let dateStr: String = format.string(from: dDate)
        return dateStr
    }

    static func dateAndTimeString(withSeconds dDate: Date) -> String {
        let format = DateFormatter()
        format.dateFormat = "MM/dd/yyyy HH:mm:ss"
        let dateStr: String = format.string(from: dDate)
        return dateStr
    }
}
