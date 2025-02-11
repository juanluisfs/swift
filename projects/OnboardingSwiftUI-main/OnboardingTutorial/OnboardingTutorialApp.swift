//
//  OnboardingTutorialApp.swift
//  OnboardingTutorial
//
//  Created by Logan Koshenka on 7/27/21.
//

import SwiftUI

@main
struct OnboardingTutorialApp: App {
    @AppStorage("isOnboarding") var isOnboarding = true
    
    var body: some Scene {
        WindowGroup {
            if isOnboarding {
                OnboardingContainerView()
            } else {
                HomeView()
            }
        }
    }
}
