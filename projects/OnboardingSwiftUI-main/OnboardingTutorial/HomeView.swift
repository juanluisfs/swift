//
//  ContentView.swift
//  OnboardingTutorial
//
//  Created by Logan Koshenka on 7/27/21.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        ZStack {
            Color.red
            
            Text("HOME VIEW")
        }
        .edgesIgnoringSafeArea(.all)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
