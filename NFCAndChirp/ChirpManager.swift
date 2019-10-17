//
//  ChirpManager.swift
//  NFCAndChirp
//
//  Created by TPS on 10/17/19.
//

import Foundation
import ChirpSDK
import AVFoundation

//let CHIRP_APP_KEY: String = "EBCEBBC1DdbcE7Cd36E72FC91";
//let CHIRP_APP_SECRET: String = "90D6aC3B7973A6C93ffd2cDCAf8B4bf5cAfB91F8520D68d23e";
//let CHIRP_APP_CONFIG: String = "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";

let CHIRP_APP_KEY: String = "b5Be8248330b35De5A5Fab5bC";
let CHIRP_APP_SECRET: String = "86a39AcdacE9C2b0D53E4E19F1b4Ec636f472A624be2DbC8e1";
let CHIRP_APP_CONFIG: String = "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";


class ChirpManager : NSObject {
    
    static let shared = ChirpManager()
    
    var chirpSDK : ChirpSDK?
    var handleSoundReaderCompleted : ((Bool,String?)->Void)?
    
    override init() {
        super.init()
        chirpSDK = ChirpSDK(appKey: CHIRP_APP_KEY, andSecret: CHIRP_APP_SECRET)
    }
    
    func isAvalableMicroPermission() -> Bool{
        return AVAudioSession.sharedInstance().recordPermission == AVAudioSession.RecordPermission.granted
    }
    
    
    func startReadingSoundData() {
        if self.isAvalableMicroPermission() {
            if let chirpSDK = chirpSDK {
                let error = chirpSDK.setConfig(CHIRP_APP_CONFIG)
                if error == nil {
                    if chirpSDK.state == CHIRP_SDK_STATE_STOPPED {
                        chirpSDK.start()
                    }
                    chirpSDK.receivedBlock = {[weak self] (data,channel) in
                        if let data = data , let message = String(data: data, encoding: .utf8) {
                            self?.handleSoundReaderCompleted?(true,message)
                        } else {
                            self?.handleSoundReaderCompleted?(false,nil)
                        }
                    }
                    
                } else {
                    print("Config Chirp: "+error!.localizedDescription)
                    handleSoundReaderCompleted?(false,nil)
                }
            } else {
                handleSoundReaderCompleted?(false,nil)
            }
        } else {
            print("Microphone Permission denied")
            AVAudioSession.sharedInstance().requestRecordPermission { (granted) in
                if granted {
                    
                }
            }
        }
    }
    
    
    func stopReadingSoundData(){
        if let chirpSDK = chirpSDK ,chirpSDK.state != CHIRP_SDK_STATE_STOPPED{
            chirpSDK.stop()
        }
    }
}
