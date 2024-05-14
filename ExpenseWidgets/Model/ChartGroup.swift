//
//  ChartGroup.swift
//  ExpenseWidgets
//
//  Created by YuChen Lin on 2024/5/7.
//

import SwiftUI

struct ChartGroup: Identifiable,Hashable {
    let id: UUID = .init()
    var date: Date
    var categories: [ChartCategory]
    var totalIncome: Double
    var totalExpense: Double
}

struct ChartCategory: Identifiable,Hashable {
    let id: UUID = .init()
    var totalValue: Double
    var category: Categories
}
