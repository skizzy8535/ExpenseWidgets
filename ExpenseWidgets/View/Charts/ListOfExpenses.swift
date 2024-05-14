//
//  ListOfExpenses.swift
//  ExpenseWidgets
//
//  Created by YuChen Lin on 2024/5/7.
//

import SwiftUI

struct ListOfExpenses: View {
    let month: Date
    
    var body: some View {
        ScrollView(.vertical) {
            LazyVStack(spacing:15) {
                Section {
                    FilteredTransactionsView(startDate: month.startOfTheMonth,
                                             endDate: month.endOfTheMonth, category: .income) { transactions in
                        ForEach(transactions) { transaction in
                            NavigationLink {
                                TransactionView(editedTransaction: transaction)
                            } label: {
                                TransactionCardView(transaction: transaction)
                            }.buttonStyle(.plain)

                        }
                    }

                } header: {
                    Text("Income")
                        .font(.caption)
                        .foregroundStyle(.gray)
                        .hSpacing(.leading)
                }

                Section {
                    FilteredTransactionsView(startDate: month.startOfTheMonth,
                                             endDate: month.endOfTheMonth, category: .expense) { transactions in

                        ForEach(transactions) { transaction in
                            NavigationLink {
                                TransactionView(editedTransaction: transaction)
                            } label: {
                                TransactionCardView(transaction: transaction)
                            }.buttonStyle(.plain)
                        }
                    }

                } header: {
                    Text("Expense")
                        .font(.caption)
                        .foregroundStyle(.gray)
                        .hSpacing(.leading)
                }

            }.padding(15)
        }
        .background(.gray.opacity(0.15))
        .navigationTitle(timeFormat(date: month, format: "MMM yy"))
    }
}
