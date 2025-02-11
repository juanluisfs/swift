//
//  OnboardingContainerView.swift
//  OnboardingTutorial
//
//  Created by Logan Koshenka on 7/27/21.
//

import SwiftUI

struct OnboardingContainerView: View {
    var body: some View {
        TabView {
            ForEach(features) { feature in
                OnboardingContentView(feature: feature)
            }
        }
        .tabViewStyle(PageTabViewStyle())
        .edgesIgnoringSafeArea(.all)
    }
}

struct OnboardingContainerView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingContainerView()
    }
}
