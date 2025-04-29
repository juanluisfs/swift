import Foundation
import AVFoundation

// 🚀 CONFIGURA ESTOS VALORES ANTES DE EJECUTAR
let inputAudioPath = "/Users/juanluisflores/Downloads/material_product_sounds/wav/02 Alerts and Notifications/notification_ambient.wav"
let outputAHAPPath = "/Users/juanluisflores/Downloads/output2.ahap"

let eventInterval = 200  // 🔥 Cuantos samples saltar para reducir resolución (Ej: 50 = más resolución, 200 = menos)
let useContinuous = false // 🎛 true = vibración larga, false = pulsos cortos (transient)
let intensityMultiplier = 1.5 // 💥 Multiplica la intensidad del haptic (Ej: 1.0 = normal, 2.0 = más fuerte)
let eventDuration = 0.05  // ⏳ Duración de cada vibración si `useContinuous = true`

func convertAudioToAHAP(audioFilePath: String, outputAHAPPath: String) {
    let url = URL(fileURLWithPath: audioFilePath)

    do {
        // 🎵 Carga el archivo de audio
        let file = try AVAudioFile(forReading: url)
        let format = file.processingFormat
        let frameCount = AVAudioFrameCount(file.length)
        let sampleRate = format.sampleRate
        let audioDuration = Double(frameCount) / sampleRate

        // 🛠 Crea un buffer de audio
        guard let buffer = AVAudioPCMBuffer(pcmFormat: format, frameCapacity: frameCount) else {
            print("❌ Error al crear el buffer PCM")
            return
        }

        try file.read(into: buffer)
        guard let floatChannelData = buffer.floatChannelData else {
            print("❌ No se encontraron datos en el canal")
            return
        }

        // 🔍 Extrae amplitudes del audio
        let frameLength = Int(buffer.frameLength)
        var amplitudes: [Float] = []

        for i in 0..<frameLength {
            let sample = abs(floatChannelData[0][i])
            amplitudes.append(sample)
        }

        let maxAmplitude = amplitudes.max() ?? 1.0  // 📊 Normaliza amplitudes
        var hapticEvents: [[String: Any]] = []

        let totalSamples = amplitudes.count
        let eventSpacing = audioDuration / Double(totalSamples)  // ⏳ Calcula el intervalo entre eventos

        // 🎛 Genera eventos hápticos en función del audio
        for (index, amplitude) in amplitudes.enumerated() where index % eventInterval == 0 {
            let time = Double(index) * eventSpacing
            if time > audioDuration { break }

            let intensity = min(1.0, Double(amplitude / maxAmplitude) * intensityMultiplier)

            // 📌 Decide si usar HapticTransient (pulsos) o HapticContinuous (vibraciones largas)
            var hapticEvent: [String: Any] = [
                "Event": [
                    "Time": time,
                    "EventType": useContinuous ? "HapticContinuous" : "HapticTransient",
                    "EventParameters": [
                        ["ParameterID": "HapticIntensity", "ParameterValue": intensity],
                        ["ParameterID": "HapticSharpness", "ParameterValue": 1.0]
                    ]
                ]
            ]

            if useContinuous {
                if var eventDict = hapticEvent["Event"] as? [String: Any] {  // 🔥 Convierte "Event" a diccionario
                    eventDict["EventDuration"] = eventDuration  // ⏳ Agrega la duración
                    hapticEvent["Event"] = eventDict  // 🔄 Vuelve a asignarlo
                }
            }

            hapticEvents.append(hapticEvent)
        }

        // 📜 Crea el JSON del AHAP
        let ahap: [String: Any] = [
            "Version": 1,
            "Metadata": ["Author": "Swift Script", "Description": "Generado desde audio"],
            "Pattern": hapticEvents
        ]

        // 📝 Convierte a JSON y guarda en archivo
        let jsonData = try JSONSerialization.data(withJSONObject: ahap, options: .prettyPrinted)
        let jsonString = String(data: jsonData, encoding: .utf8)

        try jsonString?.write(to: URL(fileURLWithPath: outputAHAPPath), atomically: true, encoding: .utf8)
        print("✅ Archivo AHAP guardado en \(outputAHAPPath)")

    } catch {
        print("❌ Error al procesar el archivo de audio: \(error.localizedDescription)")
    }
}

// 🚀 Ejecuta la conversión
convertAudioToAHAP(audioFilePath: inputAudioPath, outputAHAPPath: outputAHAPPath)



convertAudioToAHAP(audioFilePath: inputAudioPath, outputAHAPPath: outputAHAPPath)

