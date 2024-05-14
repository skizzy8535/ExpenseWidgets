//
//  AppConstants.swift
//  ExpenseWidgets
//
//  Created by YuChen Lin on 2024/5/4.

import SwiftUI

let defaultTint : Color = .red


var sampleTransactions:[Transactions] = [
    .init(title: "Airpods pro", remarks: "Apple Product", amount: 5000, createDate: .now, category: .expense, style:tints.randomElement()!),
    .init(title: "Apple Music", remarks: "Subscription", amount: 300, createDate: .now, category: .expense, style:tints.randomElement()!),
    .init(title: "House", remarks: "Payment", amount: 15000, createDate: .now, category: .income, style:tints.randomElement()!),
    .init(title: "Metro", remarks: "Go to company", amount: 800, createDate: .now, category: .expense, style:tints.randomElement()!),
]
