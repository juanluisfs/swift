func toggleFlash() {
    let device = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeVideo)
    if (device.hasTorch) {
        do {
            try device.lockForConfiguration()
            if (device.torchMode == AVCaptureTorchMode.On) {
                device.torchMode = AVCaptureTorchMode.Off
            } else {
                do {
                    try device.setTorchModeOnWithLevel(1.0)
                } catch {
                    print(error)
                }
            }
            device.unlockForConfiguration()
        } catch {
            print(error)
        }
    }
}
