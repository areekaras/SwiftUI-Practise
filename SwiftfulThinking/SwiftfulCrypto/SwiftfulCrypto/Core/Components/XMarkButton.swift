//
//  XMarkButton.swift
//  SwiftfulCrypto
//
//  Created by Shibili Areekara on 27/09/26.
//

import SwiftUI

struct XMarkButton: View {
    
    @Environment(\.presentationMode) private var presentationMode
    
    var body: some View {
        Button {
            presentationMode.wrappedValue.dismiss()
        } label: {
            Image(systemName: "xmark")
                .font(.headline)
        }
    }
}

#Preview {
    XMarkButton()
}
