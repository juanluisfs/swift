/// Handles the incoming URL and performs validations before acknowledging.
    private func handleIncomingURL(_ url: URL) {
        guard url.scheme == "yourapp" else {
            return
        }
        guard let components = URLComponents(url: url, resolvingAgainstBaseURL: true) else {
            print("Invalid URL")
            return
        }

        guard let action = components.host, action == "open-something" else {
            print("Unknown URL, we can't handle this one!")
            return
        }

        guard let something = components.queryItems?.first(where: { $0.name == "name" })?.value else {
            print("Something name not found")
            return
        }

        openSomething = something
    }
