//
//  IntroScreen.swift
//  ExpenseWidgets
//
//  Created by YuChen Lin on 2024/5/4.

import SwiftUI

struct IntroScreen: View {

    @AppStorage("isFirstLaunch") private var isFirstLaunch:Bool = true


    var body: some View {
        VStack {
            Text("What's new in Expense App?")
                .font(.largeTitle.bold())
                .multilineTextAlignment(.center)
                .padding(.top,65)
                .padding(.bottom,35)


            VStack(alignment: .leading,
                   spacing: 25 ,content: {
                InstructionView(symbol: "dollarsign", title: "Transactions", content: "Keep track of your earning and expenses")
                InstructionView(symbol: "chart.bar.fill", title: "Visable Charts", content: "View your transactions using graphic representations")
                InstructionView(symbol: "magnifyingglass", title: "Search Filters", content: "Find the expense you want to search or filter")
            })
        }
        .frame(maxWidth:.infinity ,alignment: .leading)
        .padding(.horizontal , 25)

        Spacer(minLength: 10)

        Button(action: {
            isFirstLaunch = false

        }, label: {
            Text("Continue")
                .fontWeight(.semibold)
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity)
                .padding(.vertical,15)
                .background(defaultTint.gradient)
                .cornerRadius(12)
        }).padding(15)
    }

    @ViewBuilder
    func InstructionView(symbol:String,title:String,content:String) -> some View {

        HStack(spacing: 15, content: {
            Image(systemName: symbol)
                .font(.largeTitle)
                .foregroundStyle(defaultTint.gradient)
                .frame(width: 45)

            VStack(alignment: .leading,
                   spacing: 6,
                   content: {
                Text(title)
                    .font(.title3)
                    .fontWeight(.semibold)
                Text(content)
                    .foregroundStyle(.gray)
            })

        })
    }

}




#Preview {
    IntroScreen()
}
