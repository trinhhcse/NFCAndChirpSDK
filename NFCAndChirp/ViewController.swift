//
//  ViewController.swift
//  NFCAndChirp
//
//  Created by TPS on 10/17/19.
//

import UIKit
class ViewController: UIViewController {
    
    @IBOutlet weak var contentLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @available(iOS 13.0, *)
    @IBAction func startReadDataHandle(_ sender: Any) {
        //        print(NFCManager.shared.isSupportNFCReader())
        //        NFCManager.shared.handleNFCReaderCompleted = { [weak self] (isSuccess,readedValue) in
        //            NFCManager.shared.stopReading()
        //            guard let self = self else {
        //                return
        //            }
        //
        //            if isSuccess {
        //                DispatchQueue.main.async {
        //                    self.contentLabel.text = readedValue
        //                }
        //            }
        //
        //        }
        //        NFCManager.shared.startReading()
        
        
        print(ChirpManager.shared.isAvalableMicroPermission())
        ChirpManager.shared.handleSoundReaderCompleted =  { [weak self] (isSuccess,readedValue) in
            NFCManager.shared.stopReading()
            guard let self = self else {
                return
            }
            
            if isSuccess {
                DispatchQueue.main.async {
                    self.contentLabel.text = readedValue
                }
            }
            
        }
        ChirpManager.shared.startReadingSoundData()
    }
    
}

