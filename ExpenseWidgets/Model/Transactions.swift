//
//  Transactions.swift
//  ExpenseWidgets
//
//  Created by YuChen Lin on 2024/5/4.

import SwiftUI
import SwiftData


@Model
class Transactions {

    var title :String
    var remarks:String
    var amount:Double
    var createDate:Date
    var category:String
    var style: String

    init(title: String, remarks: String, amount: Double, createDate: Date,category:Categories,style:TransactionStyle){
        self.title = title
        self.remarks = remarks
        self.amount = amount
        self.createDate = createDate
        self.category = category.rawValue
        self.style = style.theme
    }

    @Transient
    var tint: TransactionStyle? {
        return tints.first(where: { $0.theme == style })
    }

    @Transient
    var color:Color {
        return tints.first(where: { $0.theme == style })?.color ?? defaultTint
    }


    @Transient
    var rawCategory: Categories? {
        return Categories.allCases.first(where: { category == $0.rawValue })
    }


}
