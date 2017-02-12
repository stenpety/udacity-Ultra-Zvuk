//
//  PlaySoundVCExtension.swift
//  UltraZvuk
//
//  Created by Petr Stenin on 12/02/2017.
//  Copyright © 2017 Petr Stenin. All rights reserved.
//

import UIKit
import AVFoundation

extension PlaySoundViewController: AVAudioPlayerDelegate {
        
    func setupAudio() {
        do {
            soundFile = try AVAudioFile(forReading: recordedSoundURL)
        } catch {
            
        }
        
    }
    
    
    
    
}
