import SwiftUI

// MARK: Onboarding Data Model
struct OnboardingItem: Identifiable {
    let id = UUID()
    let title: String
    let subtitle: String
    let image: String
    let background: LinearGradient
}

let onboardingData: [OnboardingItem] = [
    OnboardingItem(
        title: "Welcome Aboard",
        subtitle: "Discover the full potential of our application",
        image: "globe",
        background: LinearGradient(
            gradient: Gradient(colors: [.purple, .blue]),
            startPoint: .topLeading, endPoint: .bottomTrailing)),
    OnboardingItem(
        title: "Welcome Aboard",
        subtitle: "Discover the full potential of our application",
        image: "globe",
        background: LinearGradient(
            gradient: Gradient(colors: [.pink, .orange]),
            startPoint: .topLeading, endPoint: .bottomTrailing)),
    OnboardingItem(
        title: "Welcome Aboard",
        subtitle: "Discover the full potential of our application",
        image: "globe",
        background: LinearGradient(
            gradient: Gradient(colors: [.green, .teal]),
            startPoint: .topLeading, endPoint: .bottomTrailing)),
]

struct WaveShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        path.move(to: CGPoint(x: 0, y: rect.maxY))
        
        path.addCurve(
            to: CGPoint(x: rect.width * 0.4, y: rect.midY * 1.3),
            control1: CGPoint(x: rect.width * 0.1, y: rect.maxY * 0.7),
            control2: CGPoint(x: rect.width * 0.7, y: rect.midY * 1.1))
        
        path.addCurve(
            to: CGPoint(x: rect.maxX, y: rect.minY),
            control1: CGPoint(x: rect.width * 0.9, y: rect.midY * 0.8),
            control2: CGPoint(x: rect.width * 0.95, y: rect.minY * 1.2))
        
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.closeSubpath()
        
        return path
    }
}

struct Onboarding: View {
    
    let item: OnboardingItem
    
    @State private var iconScale: CGFloat = 0.6
    
    var body: some View {
        ZStack {
            item.background
                .ignoresSafeArea()
            
            VStack {
                WaveShape()
                    .fill(Color.white.opacity(0.1))
                    .frame(height: 500)
                    .rotationEffect(.degrees(180))
                
                Spacer()
            }
            .ignoresSafeArea()
            
            VStack(spacing: 25) {
                Image(systemName: item.image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 120, height: 120)
                    .foregroundStyle(.white)
                    .shadow(color: .black.opacity(0.25), radius: 6, x: 0, y: 4)
                    .scaleEffect(iconScale)
                    .onAppear {
                        withAnimation(.spring(response: 0.6, dampingFraction: 0.6).repeatForever(autoreverses: true)) {
                            iconScale = 1.0
                        }
                    }
                
                Text(item.title)
                    .font(.system(size: 26, weight: .bold, design: .rounded))
                    .foregroundStyle(.white)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 16)
                    .shadow(color: .black.opacity(0.2), radius: 3, x: 1, y: 1)
                
                Text(item.subtitle)
                    .font(.system(size: 16, weight: .medium, design: .rounded))
                    .foregroundStyle(.white.opacity(0.85))
                    .multilineTextAlignment(.center)
                    .frame(maxWidth: 300)
                    .padding(.horizontal, 16)
                    .shadow(color: .black.opacity(0.1), radius: 2, x: 1, y: 1)
            }
            .padding(.bottom, 60)
            
        }
    }
}

struct ProOnboardingView: View {
    
    let items: [OnboardingItem]
    
    @State private var currentIndex: Int = 0
    
    var body: some View {
        ZStack {
            TabView(selection: $currentIndex) {
                ForEach(items.indices, id: \.self) { index in
                    Onboarding(item: items[index])
                        .tag(index)
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            .animation(.bouncy, value: currentIndex)
            
            VStack {
                Spacer()
                
                HStack(spacing: 8) {
                    ForEach(0..<items.count, id: \.self) { i in
                        RoundedRectangle(cornerRadius: 4)
                            .fill(Color.white.opacity(i == currentIndex ? 1 : 0.4))
                            .frame(width: i == currentIndex ? 22 : 8, height: 8)
                            .animation(.spring(), value: currentIndex)
                    }
                }
                .padding(.top, 16)
                
                if currentIndex < items.count - 1 {
                    Button("SKip") {
                        currentIndex = items.count - 1
                    }
                    .foregroundStyle(.white)
                }
                
                
                Button("Next") {
                    if currentIndex < items.count - 1 {
                        currentIndex += 1
                    }
                }
                .foregroundStyle(.white)
                .padding(.bottom, 40)
            }
            .padding(.horizontal, 20)
        }
        .ignoresSafeArea()
    }
}

