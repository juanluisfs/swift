Button("Open Deep Link") {
    UIApplication
        .shared
        .open(URL(string: "yourapp://action?name=Hey")!)
}
