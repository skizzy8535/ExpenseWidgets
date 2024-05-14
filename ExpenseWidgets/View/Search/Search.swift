//
//  Search.swift
//  ExpenseWidgets
//
//  Created by YuChen Lin on 2024/5/4.

import SwiftUI
import Combine


struct Search: View {

    @State private var searchText: String = ""
    @State private var resultText: String = ""
    @State private var selectedCategory: Categories? = nil
    
    let searchPublisher = PassthroughSubject<String, Never>()

    var body: some View {
        NavigationStack {

            ScrollView(.vertical) {
                LazyVStack(spacing: 12) {
                    FilteredTransactionsView(category: selectedCategory, searchText: resultText) { transaction in
                        ForEach(transaction) { transaction in
                            NavigationLink {
                                TransactionView(editedTransaction: transaction)
                            } label: {
                                TransactionCardView(transaction: transaction, showsCategory: true)
                            }.buttonStyle(.plain)
                        }
                    }
                    
                }
            }
            .searchable(text: $searchText,prompt: "Search History")
            .onChange(of: searchText, { oldValue, newValue in
                if newValue.isEmpty {
                    resultText = ""
                }
                searchPublisher.send(newValue)
            })
            .onReceive(searchPublisher.debounce(for: .seconds(0.6),
                                                scheduler: DispatchQueue.main), perform: { text in
                resultText = text
            })
            
            .overlay(content: {
                ContentUnavailableView("Search Transactions" ,
                                       systemImage: "magnifyingglass").opacity(searchText.isEmpty ? 1.0 : 0.0)})
            .navigationTitle("Search")
            .background(.gray.opacity(0.15))
            .toolbar{
                ToolbarItem(placement: .topBarTrailing) {
                    ToolBarContent()
                }
                
            }

        }
    }

    
    @ViewBuilder
    func ToolBarContent() -> some View {
        Menu {
            
            Button {
                selectedCategory = nil
            } label: {
                HStack {
                    Text("Both")
                    
                    if selectedCategory == nil {
                        Image(systemName: "checkmark")
                    }
                }
            }
            
            ForEach(Categories.allCases, id: \.rawValue) { category in
                Button {
                    selectedCategory = category
                } label: {
                    HStack {
                        Text(category.rawValue)
                        
                        if selectedCategory == category {
                            Image(systemName: "checkmark")
                        }
                    }
                }
            }
            
            
        } label: {
            Image(systemName: "slider.vertical.3")
        }
    }
        
    
}

#Preview {
    Search()
}
