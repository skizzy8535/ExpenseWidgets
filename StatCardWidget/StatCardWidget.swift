//
//  StatCardWidget.swift
//  StatCardWidget
//
//  Created by YuChen Lin on 2024/5/7.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> WidgetEntry {
        WidgetEntry(date: Date())
    }

    func getSnapshot(in context: Context, completion: @escaping (WidgetEntry) -> ()) {
        let entry = WidgetEntry(date: Date())
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [WidgetEntry] = []

        /*
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = WidgetEntry(date: entryDate)
            entries.append(entry)
        }
         */

        entries.append(.init(date: .now))
        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct WidgetEntry: TimelineEntry {
    let date: Date
}

struct StatCardWidgetEntryView : View {
    var entry: Provider.Entry

    var body: some View {
         FilteredTransactionsView(startDate: .now.startOfTheMonth,
                                  endDate: .now.endOfTheMonth) { transactions in

             HomeCardView(income: total(transactions,category: .income),
                          expense: total(transactions,category: .expense)
                  )
         }

    }
}

struct StatCardWidget: Widget {
    let kind: String = "StatCardWidget"

    var body: some WidgetConfiguration {
        
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            if #available(macOS 14.0, iOS 17.0, *) {
                StatCardWidgetEntryView(entry: entry)
                    .containerBackground(.fill.tertiary, for: .widget)
            } else {
                StatCardWidgetEntryView(entry: entry)
                    .padding()
                    .background()
            }
        }
        .configurationDisplayName("Expense Widget")
        .description("Show yout monthly Expense.")
    }
}

#Preview(as: .systemSmall) {
    StatCardWidget()
} timeline: {
    WidgetEntry(date: .now)

}
