//
//  Intro.swift
//  ExpenseWidgets
//
//  Created by YuChen Lin on 2024/5/4.

import SwiftUI

struct Intro: View {
    @AppStorage("isFirstLaunch") private var isFirstLaunch:Bool = true
    @State private var tabSelection : TabItem = .recents
    
    var body: some View {
        TabView(selection: $tabSelection,
                content:  {
            Recents()
                .tag(TabItem.recents)
                .tabItem { TabItem.recents.tabContent}
            Search()
                .tag(TabItem.search)
                .tabItem { TabItem.search.tabContent }
            ChartView()
                .tag(TabItem.charts)
                .tabItem { TabItem.charts.tabContent}
        })
        .tint(defaultTint)
        .sheet(isPresented: $isFirstLaunch, content: {
            IntroScreen()
                .interactiveDismissDisabled()
        })
    }
}

#Preview {
    Intro()
}
