//
//  TipsItemView.swift
//  BuildingATipJar
//
//  Created by Juan Luis Flores on 11/03/25.
//

import StoreKit
import SwiftUI

struct TipsItemView: View {
    
    @EnvironmentObject private var store: TipStore
    let item: Product?
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 3) {
                Text(item?.displayName ?? "-")
                    .font(.system(.title3, design: .rounded).bold())
                
                Text(item?.description ?? "-")
                    .font(.system(.callout, design: .rounded).weight(.regular))
            }
            
            Spacer()
            
            Button(item?.displayPrice ?? "-") {
                if let item = item {
                    Task {
                        await store.purchase(item)
                    }
                }
            }
            .tint(.blue)
            .buttonStyle(.bordered)
            .font(.callout.bold())
        }
        .padding(16)
        .background(Color(UIColor.systemBackground), in: RoundedRectangle(cornerRadius: 10, style: .continuous))
    }
}

#Preview {
    TipsItemView(item: nil)
        .environmentObject(TipStore())
}
