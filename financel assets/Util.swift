//
//  Util.swift
//  financel assets
//
//  Created by Fatih Şükran on 15.08.2023.
//

import Foundation

func areDatesEqual(date1: Date, date2: Date) -> Bool {
    let calendar = Calendar.current
    let components1 = calendar.dateComponents([.year, .month, .day], from: date1)
    let components2 = calendar.dateComponents([.year, .month, .day], from: date2)
    
    return calendar.date(from: components1) == calendar.date(from: components2)
}

//func getNearsetDate(expectedDate: Date, dates: [Date]) -> Date {
//    var nearestDate = dates.first
//    var days = 999
//
//    for date in dates {
//        let interval = date.timeIntervalSince(expectedDate)
////        interval.
//
//    }
//
//    return nearestDate
//}
