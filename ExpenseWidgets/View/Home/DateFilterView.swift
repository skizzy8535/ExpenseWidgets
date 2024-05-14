//
//  DateFilterView.swift
//  ExpenseWidgets
//
//  Created by YuChen Lin on 2024/5/6.
//

import SwiftUI

struct DateFilterView: View {

    @Binding var start :Date
    @Binding var end:Date

    var onSubmit:(Date,Date) -> ()
    var onClose:()->()


    var body: some View {

        VStack {
            DatePicker("Start Date", selection: $start ,displayedComponents: [.date])
            DatePicker("End Date", selection: $end ,displayedComponents: [.date])


            HStack(spacing: 15, content: {
                Button("Filter") {
                    onSubmit(start,end)
                }
                .padding(6)
                .foregroundStyle(.white)
                .background(defaultTint.gradient,in:.rect(cornerRadius: 8))

                Button("Cancel") {
                    onClose()
                }
                .padding(6)
                .foregroundStyle(.white)
                .background(defaultTint.gradient,in:.rect(cornerRadius: 8))

            }).padding()

        }
          .padding()
          .background(.bar , in: .rect(cornerRadius:10))
          .padding(.horizontal , 25)
    }
}


#Preview {
    DateFilterView(start: .constant(.now), end: .constant(.now)) { _ , _ in

    } onClose: {

    }

}
