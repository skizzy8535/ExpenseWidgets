//
//  Date+Additions.swift
//  ExpenseWidgets
//
//  Created by YuChen Lin on 2024/5/5.
//

import SwiftUI

extension Date {
    var startOfTheMonth:Date {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year,.month], from: self)

        return calendar.date(from: components) ?? self
    }

    var endOfTheMonth:Date {
        let calendar = Calendar.current
        let calcuEndTime = calendar.date(byAdding: .init(month:1,minute:-1), to: self.startOfTheMonth)

        return calcuEndTime ?? self
    }

}


