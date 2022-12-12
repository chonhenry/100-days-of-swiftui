//
//  ContentView.swift
//  project_3_challenge_3
//
//  Created by Henry Chon on 12/12/22.
//

import SwiftUI

struct LargeBlueTitle: ViewModifier {
    func body(content: Content) -> some View {
        content.font(.largeTitle).foregroundColor(.blue)
    }
}

extension View {
    func titleStyle() -> some View {
        modifier(LargeBlueTitle())
    }
}

struct ContentView: View {
    var body: some View {
        Text("Hello, world!")
            .titleStyle()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
