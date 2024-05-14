//
//  Recents.swift
//  ExpenseWidgets
//
//  Created by YuChen Lin on 2024/5/4.

import SwiftUI

struct Recents: View {
    
    
    @State private var startDate:Date = .now.startOfTheMonth
    @State private var endDate:Date = .now.endOfTheMonth
    @State private var showFilterView:Bool = false
    @State private var selectedCategory :Categories = .expense
    
    @Namespace private var segmentAnimation
        
    
    var body: some View {
        GeometryReader { proxy in
            
            let size = proxy.size
            
            NavigationStack {
                ScrollView(.vertical) {
                    LazyVStack(spacing:10 ,pinnedViews:[.sectionHeaders]) {
                        Section {
                            Button(action: {
                                showFilterView = true
                            }, label: {
                                Text("\(timeFormat(date:startDate,format:"MMM-dd,yy")) to \(timeFormat(date:endDate,format:"MMM-dd,yy")) ")
                                    .font(.caption2)
                                    .foregroundStyle(.gray)
                            })
                            .hSpacing(.leading)
                            
                            
                            FilteredTransactionsView(startDate: startDate, endDate: endDate) { transactions in
                                HomeCardView(
                                    income: total(transactions, category: .income),
                                    expense: total(transactions, category: .expense)
                                )
                                
                                CustomHomeSegmentControl()
                                    .padding(.bottom , 10)
                                
                                ForEach(transactions.filter({$0.category == selectedCategory.rawValue})) { transaction in
                                
                                    NavigationLink(value: transaction) {
                                        TransactionCardView(transaction: transaction)
                                    }.buttonStyle(.plain)
                                    
                                }
                            }
                        } header: {
                            HeaderView(size)
                        }
                        
                    }
                    .padding(15)
                }
                .background(.gray.opacity(0.15))
                .blur(radius: showFilterView ? 8 : 0)
                .disabled(showFilterView)
                .navigationDestination(for: Transactions.self) { transaction in
                    TransactionView(editedTransaction: transaction)
                }
                
            }.overlay {
                
                if showFilterView {
                    DateFilterView(start: $startDate, end: $endDate, onSubmit: { start, end in
                        startDate = start
                        endDate = end
                        showFilterView = false
                    }, onClose: {
                        showFilterView = false
                    })
                    .transition(.move(edge: .leading))
                }
            }.animation(.snappy,value:showFilterView)
            
        }
    }
    
    
    @ViewBuilder
    func HeaderView(_ size: CGSize) -> some View {
        HStack (spacing:20){
            
            VStack(alignment: .leading, spacing:2) {
                Text("Welcome !")
                    .font(.title)
                    .fontWeight(.bold)
                
            }
            .visualEffect { content, geometryProxy in
                content.scaleEffect(headerScale(size, proxy: geometryProxy),anchor: .topLeading)
            }
            
            Spacer()
            
            NavigationLink {
                TransactionView()
            } label: {
                Image(systemName: "plus")
                    .font(.title)
                    .fontWeight(.semibold)
                    .foregroundStyle(.white)
                    .padding(10)
                    .background(defaultTint.gradient,in:.circle)
                    .contentShape(.circle)
            }
            
        }
        .padding(.bottom,5)
        .background(
            VStack(spacing:0) {
                Rectangle()
                    .fill(.ultraThinMaterial)
                
                Divider()
            }
                .visualEffect { content, geometryProxy in
                    content.opacity(headerBackGroundOpcaity(geometryProxy))
                }
                .padding(.horizontal, -15)
                .padding(.top, -(safeArea.top + 15))
            
        )
        
    }
    
    func headerBackGroundOpcaity (_ proxy:GeometryProxy) -> CGFloat{
        let minY = proxy.frame(in: .scrollView).minY + safeArea.top
        return minY > 0 ? 0 : -(minY/15)
    }
    
    func headerScale (_ size:CGSize,proxy:GeometryProxy) -> CGFloat{
        let minY = proxy.frame(in: .scrollView).minY
        let screenHeight = size.height
        let progress = minY / screenHeight
        let scale = min(max(progress,0),1)*0.3
        return 1+scale
    }
    
    
    @ViewBuilder
    func CustomHomeSegmentControl () -> some View {
        
        HStack(spacing:0) {
            ForEach(Categories.allCases ,id:\.rawValue) { category in
                Text(category.rawValue)
                    .hSpacing()
                    .padding(.vertical , 10)
                    .background{
                        
                        if (category == selectedCategory) {
                            Capsule()
                                .fill(.white)
                                .matchedGeometryEffect(id: "ActiveTab", in: segmentAnimation)
                        }
                        
                    }
                    .contentShape(.capsule)
                    .onTapGesture {
                        withAnimation(.smooth) {
                            selectedCategory = category
                        }
                    }
                
            }
        }
        .background(.gray.opacity(0.35), in: .capsule)
        .padding(.top , 5)
        
    }
    
    
    
}

#Preview {
    Recents()
}
