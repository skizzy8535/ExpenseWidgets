//
//  View+Additions.swift
//  ExpenseWidgets
//
//  Created by YuChen Lin on 2024/5/5.
//

import SwiftUI
import Charts


extension View {

    @ViewBuilder
    func hSpacing(_ alignment:Alignment = .center) -> some View {
        self.frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/,alignment: alignment)
    }

    @ViewBuilder
    func vSpacing(_ alignment:Alignment = .center) -> some View {
        self.frame(maxHeight: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/,alignment: alignment)
    }

    @available(iOSApplicationExtension, unavailable)
    var safeArea: UIEdgeInsets {
        if let windowScene = (UIApplication.shared.connectedScenes.first as? UIWindowScene) {
            return windowScene.keyWindow?.safeAreaInsets ?? .zero
        }
        return .zero
    }

    func timeFormat(date:Date,format:String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: date)
    }


    func currencyString(_ value:Double , allowDigits:Int = 2) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.maximumFractionDigits = allowDigits
        return formatter.string(from: .init(value: value)) ?? ""
    }

    var currencySymbol: String {
        let locale = Locale.current
        return locale.currencySymbol ?? ""
    }

    func total(_ transactions: [Transactions], category: Categories) -> Double {
        return transactions.filter({ $0.category == category.rawValue }).reduce(Double.zero) { partialResult, transaction in
            return partialResult + transaction.amount
        }
    }
    

}


