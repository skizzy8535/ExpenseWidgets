//
//  HomeCardView.swift
//  ExpenseWidgets
//
//  Created by YuChen Lin on 2024/5/5.
//

import SwiftUI

struct HomeCardView: View {

     var income:Double
     var expense:Double

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 15)
                .fill(.background)

            VStack (spacing:0){
                HStack (spacing: 12) {
                    Text("\(currencyString(income - expense))")
                        .font(.title)
                        .fontWeight(.bold)

                    Image(systemName: income > expense ? "chart.line.uptrend.xyaxis" : "chart.line.downtrend.xyaxis")
                        .font(.title3)
                        .foregroundStyle(income > expense ? .green:.red)
                }


                HStack(spacing: 8) {

                    ForEach(Categories.allCases,id: \.rawValue)  { category in

                        let tint = category == .income ? Color.green: Color.red

                        HStack(spacing:10) {
                            Image(systemName: category == .income ? "arrow.up" : "arrow.down")
                                .font(.callout)
                                .fontWeight(.bold)
                                .foregroundStyle(tint)
                                .frame(width: 35, height: 35)
                                .background {
                                    Circle()
                                        .fill(tint.opacity(0.25).gradient)
                                }


                            VStack(alignment: .leading, spacing: 3) {
                                Text(category.rawValue)
                                    .font(.caption2)
                                    .foregroundStyle(.gray)


                                Text(currencyString(category == .income ? income : expense, allowDigits: 0))
                                    .font(.callout)
                                    .fontWeight(.semibold)
                            }

                            if (category == .income) {
                                Spacer(minLength: 10)
                            }

                        }
                    }

                }

            }
            .padding([.horizontal,.bottom],25)
            .padding([.top],15)
        }

    }
}

#Preview {
    HomeCardView(income: 50000, expense:18000)
}
