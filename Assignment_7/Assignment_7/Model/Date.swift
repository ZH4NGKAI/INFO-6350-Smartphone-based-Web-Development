//
//  Date.swift
//  Assignment_7
//
//  Created by mac on 3/24/20.
//  Copyright © 2020 Kai Zhang. All rights reserved.
//
import Foundation

class Date {
    class func parse(_ string: String, format: String = "yyyy-MM-dd") -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = NSTimeZone.default
        dateFormatter.dateFormat = format

        let date = dateFormatter.date(from: string)!
        return date
    }
}
