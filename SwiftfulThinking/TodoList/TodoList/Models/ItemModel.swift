//
//  ItemModel.swift
//  TodoList
//
//  Created by Shibili Areekara on 15/09/26.
//

import Foundation

struct ItemModel: Identifiable {
    let id: String = UUID().uuidString
    let title: String
    let isCompleted: Bool
}
