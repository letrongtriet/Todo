//
//  String+Extension.swift
//  Todo
//
//  Created by Triet M1 Macbook Pro on 15.3.2021.
//

import Foundation

extension String {
    var date: Date {
        let currentDate = Date()
        var dateComponent = DateComponents()
        dateComponent.day = Int(self)
        return Calendar.current.date(byAdding: dateComponent, to: currentDate) ?? currentDate
    }
}
