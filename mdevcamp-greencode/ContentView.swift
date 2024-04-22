//
//  ContentView.swift
//  mdevcamp-greencode
//
//  Created by Peter Schmiedt on 22.04.2024.
//

import MAUL
import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
            .maulFontStyle(.h1)
            .foregroundColor(.MAUL.Text.primary)

        }
        .padding()
    }
}

#Preview {
    ContentView()
}
