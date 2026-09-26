//
//  SearchBarView.swift
//  SwiftfulCrypto
//
//  Created by Shibili Areekara on 26/09/26.
//

import SwiftUI

struct SearchBarView: View {
    
    @Binding var searchText: String
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(
                    searchText.isEmpty ? Color.theme.secondaryText : Color.theme.accent
                )
            
            TextField("Search by name or Symbol...", text: $searchText)
                .autocorrectionDisabled()
                .foregroundColor(Color.theme.accent)
                .overlay(alignment: .trailing, content: {
                    Image(systemName: "xmark.circle.fill")
                        .padding()
                        .offset(x: 10)
                        .foregroundColor(Color.theme.accent)
                        .opacity(searchText.isEmpty ? 0.0 : 1.0)
                        .onTapGesture {
                            UIApplication.shared.endEditing()
                            searchText = ""
                        }
                })
        }
        .font(.headline)
        .padding()
        .background {
            RoundedRectangle(cornerRadius: 25)
                .fill(Color.theme.background)
                .shadow(
                    color: Color.theme.accent.opacity(0.15),
                    radius: 10, x: 0, y: 0)
        }
        .padding()
        
    }
}

#Preview("Light Mode") {
    SearchBarView(searchText: .constant(""))
            .preferredColorScheme(.light)
}

#Preview("Dark Mode") {
        SearchBarView(searchText: .constant(""))
            .preferredColorScheme(.dark)
}
