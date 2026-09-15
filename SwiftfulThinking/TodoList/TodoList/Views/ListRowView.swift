//
//  ListRowView.swift
//  TodoList
//
//  Created by Shibili Areekara on 15/09/26.
//

import SwiftUI

struct ListRowView: View {
    
    let item: ItemModel
    
    var body: some View {
        HStack {
            Image(systemName: item.isCompleted ? "checkmark.circle": "circle")
                .foregroundColor(item.isCompleted ? .green : .red)
            
            Text("\(item.title)")
            Spacer()
        }
        .font(.title2)
        .padding(.vertical, 8)
    }
}

#Preview {
    let item1 = ItemModel(title: "This is the first title", isCompleted: false)
    let item2 = ItemModel(title: "This is the second title", isCompleted: true)
    
    Group {
        ListRowView(item: item1)
        ListRowView(item: item2)
    }
    
}

