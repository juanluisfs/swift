//
//  OnboardingContentView.swift
//  OnboardingTutorial
//
//  Created by Logan Koshenka on 7/27/21.
//

import SwiftUI

let features = [
    Feature(title: "Start saving today", subtitle: "Find new ways to save money based on subscriptions, bills, and more.", image: "pennyJar"),
    Feature(title: "Automate investing", subtitle: "Open investment accounts that work while you sleep", image: "dollas"),
    Feature(title: "Analyze expenses", subtitle: "Use our analytics platform to see where you can save", image: "laptop")
]

struct OnboardingContentView: View {
    @AppStorage("isOnboarding") var isOnboarding: Bool?
    var feature: Feature
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color.blue, Color.teal]), startPoint: .topLeading, endPoint: .bottomTrailing)
            VStack {
                Spacer()
                Image(feature.image)
                    .resizable()
                    .scaledToFit()
                Spacer()
                
                VStack(spacing: 20) {
                    Text(feature.title)
                        .font(.system(size: 24, weight: .bold))
                    Text(feature.subtitle)
                        .font(.caption)
                }
                .padding()
                
                Spacer()
                
                Button(action: { isOnboarding = false }, label: {
                    Text("Start")
                        .padding()
                        .background(
                            Capsule().strokeBorder(Color.white, lineWidth: 1.5)
                                .frame(width: 100)
                        )
                })
                
                Spacer()
            }
        }
        .edgesIgnoringSafeArea(.all)
    }
}

struct OnboardingContentView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingContentView(feature: features[0])
    }
}
