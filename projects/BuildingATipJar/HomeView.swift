//
//  HomeView.swift
//  BuildingATipJar
//
//  Created by Juan Luis Flores on 11/03/25.
//

import SwiftUI

struct HomeView: View {
    
    @State private var showTips = false
    @State private var showThanks = false
    @AppStorage("isPremium") var isPremium: Bool = false
    
    @EnvironmentObject var store: TipStore
    
    var body: some View {
        VStack {
            if isPremium {
                Text("You're Premium")
            } else {
                Button("Comprar Premium") {
                    Task {
                        if let premiumProduct = store.items.first(where: { $0.id == "com.jlfs.BuildingATipJar.tinyTip"}) {
                            await store.purchase(premiumProduct)
                            await store.checkUserEntitlements()
                        }
                    }
                }
            }
            
            Button("Tip Me") {
                showTips.toggle()
            }
            .tint(.blue)
            .buttonStyle(.bordered)
        }
        .task {
            await store.checkUserEntitlements()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .overlay {
            if showTips {
                Color.black.opacity(0.8)
                    .ignoresSafeArea()
                    .transition(.opacity)
                    .onTapGesture {
                        showTips.toggle()
                    }
                
                TipsView {
                    showTips.toggle()
                }
                .environmentObject(store)
                .transition(.move(edge: .bottom))
            }
        }
        .overlay(alignment: .bottom) {
            if showThanks {
                ThanksView {
                    showThanks = false
                }
                .transition(.move(edge: .bottom).combined(with: .opacity))
            }
        }
        .animation(.spring, value: showTips)
        .animation(.spring, value: showThanks)
        .onChange(of: store.action, { oldValue, newValue in
            if newValue == .succesful {
                showTips = false
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    showThanks = true
                    store.reset()
                }
            }
        })
        .alert(isPresented: $store.hasError, error: store.error) {
            //
        }
    }
}

#Preview {
    HomeView()
        .environmentObject(TipStore())
}
