NavigationLink(destination: TradeView(trade: trade)) {
    Text("Trade View Link")
}.simultaneousGesture(TapGesture().onEnded {
    print("Hello world!")
})
