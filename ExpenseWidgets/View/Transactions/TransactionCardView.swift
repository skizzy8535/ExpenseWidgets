//
//  TransactionCardView.swift
//  ExpenseWidgets
//
//  Created by YuChen Lin on 2024/5/5.
//

import SwiftUI

struct TransactionCardView: View {

    @Environment(\.modelContext) private var context
    var transaction:Transactions
    var showsCategory: Bool = false

    var body: some View {

        SwipeAction(cornerRadius:15,direction:.trailing) {
            HStack (spacing:12) {
                Text("\(String(transaction.title.prefix(1)))")
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    .fontWeight(.semibold)
                    .foregroundStyle(.white)
                    .frame(width: 45,height: 45)
                    .background(transaction.color.gradient , in:.circle)


                VStack(alignment: .leading,
                       spacing: 4 ,
                       content: {

                    Text(transaction.title)
                        .foregroundStyle(.primary)

                    Text(transaction.remarks)
                        .font(.caption)
                        .foregroundStyle(.secondary)

                    Text(timeFormat(date: transaction.createDate ,format:"dd MMM yyyy"))
                        .font(.caption)
                        .foregroundStyle(.secondary)


                    if showsCategory {
                        Text(transaction.category)
                            .font(.caption2)
                            .padding(.horizontal, 8)
                            .padding(.vertical, 2)
                            .foregroundStyle(.white)
                            .background(transaction.category == Categories.income.rawValue ? Color.green.gradient : Color.red.gradient, in: .capsule)
                    }

                })
                .lineLimit(1)
                .hSpacing(.leading)

                Text(currencyString(transaction.amount,allowDigits:2))
                    .fontWeight(.semibold)

            }
            .padding(.horizontal,15)
            .padding(.vertical,10)
            .background(.background,in:.rect(cornerRadius:10))

        } actions: {
            Action(tint: .red, icon: "trash.fill") {
                context.delete(transaction)
            }
        }


    }
}

#Preview {
    TransactionCardView(transaction:sampleTransactions[0])
}
