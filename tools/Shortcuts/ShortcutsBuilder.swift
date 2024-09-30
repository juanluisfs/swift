import AppIntents

struct DynamicMeShortcutProvider: AppShortcutsProvider {
    static var appShortcuts: [AppShortcut] {
        AppShortcut(
            intent: Intent(),  // Add the intent that will run                     -  Agregar el intento que se ejecutará
            phrases: [         // Add the phrases that call the shortcut via Siri  -  Ańadir las frases para llamar el atajo vía Siri
                "Update \(.applicationName) date and time",
                "Update \(.applicationName)"
            ],
            shortTitle: "Update date and time",        // Add shortcut title  -  Añadir el título del atajo
            systemImageName: "calendar.badge.clock"    // Add shortcut SF Symbol  -  Añadir el SF Symbol del atajo
        )
    }
}
