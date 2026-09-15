//
//  ListView.swift
//  TodoList
//
//  Created by Shibili Areekara on 15/09/26.
//

import SwiftUI

struct ListView: View {
    
    @State var items: [String] = [
        "This is the first title!",
        "This is the second!",
        "Third!"
    ]
    
    var body: some View {
        List {
            ForEach(items, id: \.self) { item in
                ListRowView(title: "\(item)")
            }
        }
        .listStyle(PlainListStyle())
        .navigationTitle("Todo List 📝")
        .navigationBarItems(
            leading: EditButton(),
            trailing: NavigationLink("Add", destination: AddItem())
        )
    }
}

#Preview {
    NavigationView {
        ListView()
    }
}
