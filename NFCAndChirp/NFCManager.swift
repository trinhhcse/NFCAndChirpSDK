//
//  NFCManager.swift
//  NFCAndChirp
//
//  Created by TPS on 10/17/19.
//

import Foundation
import CoreNFC
@available(iOS 13.0, *)
class NFCManager : NSObject{
    static let shared = NFCManager()
    
    var nfcSession : NFCNDEFReaderSession?
    var handleNFCReaderCompleted : ((Bool,String?)->Void)?
    
    
    private override init(){
        super.init()
        self.nfcSession = NFCNDEFReaderSession(delegate: self, queue: DispatchQueue.global(), invalidateAfterFirstRead: false)
    }
    
}

//MARK: Support Function
@available(iOS 13.0, *)
extension NFCManager {
    
    func isSupportNFCReader() -> Bool {
        return NFCNDEFReaderSession.readingAvailable
    }
    
    func startReading() {
        if nfcSession == nil {
           self.nfcSession = NFCNDEFReaderSession(delegate: self, queue: DispatchQueue.global(), invalidateAfterFirstRead: false)
        }
        
        nfcSession?.alertMessage = "Hold your iPhone near the item to learn more about it."
        
        guard let nfcSession = nfcSession else {
            return
        }
        
        if !nfcSession.isReady {
            nfcSession.begin()
        }
    }
    
    func stopReading() {
        if  let nfcSession = nfcSession, nfcSession.isReady {
            nfcSession.invalidate()
        }
    }
    
}

//MARK: NFCNDEFReaderSessionDelegate
@available(iOS 13.0, *)
extension NFCManager : NFCNDEFReaderSessionDelegate {
    
    //Detect message
    func readerSession(_ session: NFCNDEFReaderSession, didDetectNDEFs messages: [NFCNDEFMessage]) {
        let nfcMesasages : NFCNDEFMessage? = messages.first
        let payload : NFCNDEFPayload? = nfcMesasages?.records.first
        
        if let data = payload?.payload {
            var message = String(data: data, encoding: .utf8) ?? ""
            message = message.replacingOccurrences(of:"\n", with: "")
            message = message.replacingOccurrences(of: "\0", with: "")
            self.handleNFCReaderCompleted?(true,message)
        } else {
            self.handleNFCReaderCompleted?(false,nil)
        }
        
    }
    
    func readerSession(_ session: NFCNDEFReaderSession, didInvalidateWithError error: Error) {
        print("didInvalidateWithError")
    }
    
    func readerSessionDidBecomeActive(_ session: NFCNDEFReaderSession) {
        print("readerSessionDidBecomeActive")
    }
}
