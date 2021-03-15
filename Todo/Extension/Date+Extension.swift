//
//  Date+Extension.swift
//  Todo
//
//  Created by Triet M1 Macbook Pro on 15.3.2021.
//

import Foundation

extension Date {
    var displayString: String? {
        if Date() >= self {
            return "Overdue!"
        } else {
            let numberOfDays = Calendar.current.numberOfDaysBetween(Date(), and: self)
            return "Due in \(numberOfDays) \(numberOfDays > 1 ? "days" : "days")"
        }
    }
}

extension Calendar {
    func numberOfDaysBetween(_ from: Date, and to: Date) -> Int {
        let fromDate = startOfDay(for: from)
        let toDate = startOfDay(for: to)
        let numberOfDays = dateComponents([.day], from: fromDate, to: toDate)
        return numberOfDays.day!
    }
}
