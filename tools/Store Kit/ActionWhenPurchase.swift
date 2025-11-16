struct MyView: View {
    @State private var purchaseCompleted = false
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        YourView()
            .onInAppPurchaseCompletion { product, result in
                // handle result
                purchaseCompleted = true
            }
            .onChange(of: purchaseCompleted) { _, _ in
                dismiss()
            }
    }
}
