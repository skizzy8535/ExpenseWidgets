//
//  TabItem.swift
//  ExpenseWidgets
//
//  Created by YuChen Lin on 2024/5/4.

import SwiftUI

enum TabItem :String{
    case recents = "Recents"
    case search = "Search"
    case charts = "Charts"
    case settings = "Settings"

    @ViewBuilder
    var tabContent:some View{

        switch self {
         case .recents:
            Image(systemName: "calendar")
            Text(self.rawValue)
          case .search:
            Image(systemName: "magnifyingglass")
            Text(self.rawValue)
          case .charts:
            Image(systemName: "chart.bar.xaxis")
            Text(self.rawValue)
         case .settings:
            Image(systemName: "gearshape")
            Text(self.rawValue)
        }

    }

}
