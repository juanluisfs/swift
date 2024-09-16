//MARK: Needs the extension provided in GetDeviceModel.swift

func compatible() -> Bool {
        let model = UIDevice.modelName
        switch model {
        case "iPhone 14 Pro","iPhone 14 Pro Max","iPhone 15","iPhone 15 Plus","iPhone 15 Pro","iPhone 15 Pro Max","iPhone 16","iPhone 16 Plus","iPhone 16 Pro","iPhone 16 Pro Max":
            return true
        default:
            return false
        }
    }
