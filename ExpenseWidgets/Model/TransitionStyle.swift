//
//  TransactionStyle.swift
//  ExpenseWidgets
//
//  Created by YuChen Lin on 2024/5/7.
//

import SwiftUI

struct TransactionStyle: Identifiable {
    let id: UUID = .init()
    var theme: String
    var color: Color
}


var tints: [TransactionStyle] = [
    .init(theme: "Red", color: .red),
    .init(theme: "Blue", color: .blue),
    .init(theme: "Cyan", color: .cyan),
    .init(theme: "Pink", color: .pink),
    .init(theme: "Purple", color: .purple),
    .init(theme: "Brown", color: .brown),
    .init(theme: "Orange", color: .orange),
    .init(theme: "Teal", color: .teal),
    .init(theme: "Gray", color: .gray),
]
