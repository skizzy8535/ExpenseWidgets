//
//  ExpenseWidgetsApp.swift
//  ExpenseWidgets
//
//  Created by YuChen Lin on 2024/5/3.
//

import SwiftUI
import WidgetKit



@main
struct Expense_TrackerApp: App {
    @Environment(\.scenePhase) private var scene
    var body: some Scene {
        WindowGroup {
            Intro()
                .onChange(of: scene, { oldValue, newValue in
                    if newValue == .background {
                        WidgetCenter.shared.reloadAllTimelines()
                    }
                })
        }
        .modelContainer(for: [Transactions.self])
    }
}


