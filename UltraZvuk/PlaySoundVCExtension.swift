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
    
    // MARK: Setup audio function - trying to assign soundFile to obtained URL
    
    func setupAudio() {
        do {
            soundFile = try AVAudioFile(forReading: recordedSoundURL)
        } catch {
            showAlert(forVC: self, withTitle: "AudioFileError", andMessage: "Audio File Error!")
        }
        
    }
    
    func playSound(rate: Float? = nil, pitch: Float? = nil, echo: Bool = false, reverb: Bool = false) {
        
        // Initialize Audio Engine
        soundEngine = AVAudioEngine()
        
        // Create an audio PLAYER node and attach it to the audio engine
        soundPlayerNode = AVAudioPlayerNode()
        soundEngine.attach(soundPlayerNode)
        
        
        // Node for adjustinf time/pitch
        let soundChangeTimePitchNode = AVAudioUnitTimePitch()
        
        if let rate = rate {
            soundChangeTimePitchNode.rate = rate
        }
        
        if let pitch = pitch {
            soundChangeTimePitchNode.pitch = pitch
        }
        
        soundEngine.attach(soundChangeTimePitchNode)
        
        
        // Node for adding Echo effect
        let soundChangeEchoNode = AVAudioUnitDistortion()
        soundChangeEchoNode.loadFactoryPreset(.multiEcho2)
        soundEngine.attach(soundChangeEchoNode)
        
        
        // Node for adding Reverb effect
        let soundChangeReverbNode = AVAudioUnitReverb()
        soundChangeReverbNode.loadFactoryPreset(.largeRoom2)
        soundChangeReverbNode.wetDryMix = 50
        soundEngine.attach(soundChangeReverbNode)
        
        
        
        
        
    }
    
    
    
    
    
    
    // MARK: Aux functions
    
    func connectAudioNodes(_ nodes: [AVAudioNode]) {
        for i in 0..<nodes.count-1 {
            soundEngine.connect(nodes[i], to: nodes[i+1], format: soundFile.processingFormat)
        }
    }
    
    
    
}
