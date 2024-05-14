//
//  TransactionView.swift
//  ExpenseWidgets
//
//  Created by YuChen Lin on 2024/5/7.
//

import SwiftUI
import WidgetKit

struct TransactionView: View {

    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss

    var editedTransaction: Transactions?

    @State private var title: String = ""
    @State private var remarks: String = ""
    @State private var amount: Double = .zero
    @State private var dateAdded: Date = .now
    @State private var category: Categories = .expense
    @State var tint: TransactionStyle = tints.randomElement()!

    var body: some View {

        ScrollView(.vertical) {
            VStack(spacing: 15) {

                Text("Preview")
                    .font(.caption)
                    .foregroundStyle(.gray)
                    .hSpacing(.leading)

                TransactionCardView(transaction: .init(
                    title: title.isEmpty ? "Title" : title,
                    remarks: remarks.isEmpty ? "Remarks" : remarks,
                    amount: amount,
                    createDate: dateAdded,
                    category: category,
                    style: tint))

                CustomSection("Title", "Magic Keyboard", value: $title)

                CustomSection("Remarks", "Apple Product!", value: $remarks)

                VStack(alignment: .leading, spacing: 10, content: {
                    Text("Amount & Category")
                        .font(.caption)
                        .foregroundStyle(.gray)
                        .hSpacing(.leading)

                    HStack(spacing: 15) {
                        HStack(spacing: 4) {
                            Text(currencySymbol)
                                .font(.callout.bold())

                            TextField("0.0", value: $amount, formatter: numberFormatter)
                                .keyboardType(.decimalPad)
                        }
                        .padding(.horizontal, 15)
                        .padding(.vertical, 12)
                        .background(.background, in: .rect(cornerRadius: 10))
                        .frame(maxWidth: 130)

                        CategoryCheckBox()
                    }
                })

                /// Date Picker
                VStack(alignment: .leading, spacing: 10, content: {
                    Text("Date")
                        .font(.caption)
                        .foregroundStyle(.gray)
                        .hSpacing(.leading)

                    DatePicker("", selection: $dateAdded, displayedComponents: [.date])
                        .datePickerStyle(.graphical)
                        .padding(.horizontal, 15)
                        .padding(.vertical, 12)
                        .background(.background, in: .rect(cornerRadius: 10))
                })
            }
            .padding(15)
        }
        .navigationTitle("\(editedTransaction == nil ? "Add" : "Edit") Transaction")
        .background(.gray.opacity(0.15))
        .toolbar(content: {
            ToolbarItem(placement: .topBarTrailing) {
                Button("Save", action: save)
            }
        })
        .onAppear(perform: {
            if let editedTransaction {
                title = editedTransaction.title
                remarks = editedTransaction.remarks
                dateAdded = editedTransaction.createDate
                if let category = editedTransaction.rawCategory {
                    self.category = category
                }
                amount = editedTransaction.amount
                if let tint = editedTransaction.tint {
                    self.tint = tint
                }

            }
        })



    }

    func save() {
        if editedTransaction != nil {
            editedTransaction?.title = title
            editedTransaction?.remarks = remarks
            editedTransaction?.amount = amount
            editedTransaction?.createDate = dateAdded
            editedTransaction?.category = category.rawValue
            
        } else {
            let transaction = Transactions(title: title, remarks: remarks, amount: amount, createDate: dateAdded, category: category, style: tint)
            context.insert(transaction)
            
        }

        dismiss()
        
        WidgetCenter.shared.reloadAllTimelines()
    }

    @ViewBuilder
    func CustomSection(_ title: String, _ hint: String, value: Binding<String>) -> some View {
        VStack(alignment: .leading, spacing: 5, content: {
            Text(title)
                .font(.caption)
                .foregroundStyle(.gray)
                .hSpacing(.leading)

            TextField(hint, text: value)
                .padding(.horizontal, 15)
                .padding(.vertical, 12)
                .background(.background, in: .rect(cornerRadius: 10))
        })
    }

    @ViewBuilder
    func CategoryCheckBox() -> some View {
        HStack(spacing: 10) {

            ForEach(Categories.allCases,id: \.rawValue) { category in

                HStack(spacing:8) {

                    ZStack {
                        Image(systemName: "circle")
                            .font(.title3)
                        .foregroundStyle(defaultTint)

                        if self.category == category {
                            Image(systemName: "circle.fill")
                                .font(.caption)
                                .foregroundStyle(defaultTint)
                        }
                    }

                    Text(category.rawValue)
                        .font(.caption)
                }
                .contentShape(.rect)
                .onTapGesture {
                    self.category = category
                }

            }
    
        }
        .padding(.horizontal,15)
        .padding(.vertical,12)
        .hSpacing(.leading)
        .background(.background, in: .rect(cornerRadius: 10))
    }

    var numberFormatter: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 2
        return formatter
    }
}

#Preview {
    TransactionView()
        .modelContainer(for: Transactions.self)
}
