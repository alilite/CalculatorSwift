//
//  ContentView.swift
//  Calculator Swift UI
//
//  Created by Ali Bahiraei on 2024-09-22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack{
            LinearGradient(gradient: Gradient(colors: [.pink.opacity(0.5), .purple.opacity(0.3)]), startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            KeyView()
        }
    }
}

#Preview {
    ContentView()
}
