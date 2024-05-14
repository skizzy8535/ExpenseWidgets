//
//  FilteredTransactionsView.swift
//  ExpenseWidgets
//
//  Created by YuChen Lin on 2024/5/7.
//

import SwiftUI
import SwiftData


/// Custom View

// MARK : 顯示紀錄的View
struct FilteredTransactionsView<Content:View>: View {

    var content: ([Transactions]) -> Content
    @Query(animation: .snappy) private var transactions: [Transactions]

    // 一般的紀錄View
    init(startDate:Date,endDate:Date , @ViewBuilder content: @escaping ([Transactions]) -> Content) {

        let cardPredicate = #Predicate<Transactions>{ transaction in
            return transaction.createDate >= startDate && transaction.createDate <= endDate
        }


        _transactions = Query(filter: cardPredicate ,
                              sort: [SortDescriptor(\Transactions.createDate,order:.reverse)],
                              animation: .snappy)

        self.content = content
    }


    // 搜尋頁(有分類 + 關鍵字)
    init(category:Categories?, searchText:String , @ViewBuilder content: @escaping ([Transactions]) -> Content) {

        let selectedCategory = category?.rawValue ?? ""

        let transactionPredicate = #Predicate<Transactions> { transaction in
            return (transaction.title.localizedStandardContains(searchText) || transaction.remarks.localizedStandardContains(searchText))
                   &&  (selectedCategory.isEmpty ? true : transaction.category == selectedCategory)
        }
        
        _transactions = Query(filter: transactionPredicate, sort: [
            SortDescriptor(\Transactions.createDate, order: .reverse)
        ], animation: .snappy)

        self.content = content
    }

    // 在Graph 頁點開詳細項時使用

    init(startDate: Date, endDate: Date, category: Categories?, @ViewBuilder content: @escaping ([Transactions]) -> Content) {
        /// Custom Predicate

        let rawValue = category?.rawValue ?? ""
        let predicate = #Predicate<Transactions> { transaction in
            return (transaction.createDate >= startDate && transaction.createDate <= endDate) &&
            (rawValue.isEmpty ? true : transaction.category == rawValue)
        }

        _transactions = Query(filter: predicate, sort: [
            SortDescriptor(\Transactions.createDate, order: .reverse)
        ], animation: .snappy)

        self.content = content
    }


    var body: some View {
        content(transactions)
    }
}

