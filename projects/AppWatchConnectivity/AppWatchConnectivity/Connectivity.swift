//
//  Connectivity.swift
//  AppWatchConnectivity
//
//  Created by Juan Luis Flores on 17/04/25.
//

import Foundation
import WatchConnectivity

class Connectivity: NSObject, ObservableObject, WCSessionDelegate {
    
    @Published var receivedText = ""
    
    override init() {
        super.init()
        
        if WCSession.isSupported() {
            let session = WCSession.default
            session.delegate = self
            session.activate()
        }
    }
    
#if os(iOS)
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        Task { @MainActor in
            if activationState == .activated {
                if session.isWatchAppInstalled {
                    self.receivedText = "Watch app is installed!"
                }
            }
        }
    }
    
    func sessionDidBecomeInactive(_ session: WCSession) {
        //
    }
    
    func sessionDidDeactivate(_ session: WCSession) {
        //
    }
#else
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        
    }
#endif
   
    func sendMessage(_ data: [String: Any]) {
        let session = WCSession.default
        
        if session.isReachable {
            session.sendMessage(data) { response in
                Task { @MainActor in
                    self.receivedText = "Received: \(response)"
                }
            }
        }
    }
    
    func session(_ session: WCSession, didReceiveMessage message: [String: Any], replyHandler replayHandler: @escaping ([String:Any]) -> Void) {
        Task { @MainActor in
            if let text = message["text"] as? String {
                self.receivedText = text
                replayHandler(["response":"Be excellent to each other"])
            }
        }
    }
}
