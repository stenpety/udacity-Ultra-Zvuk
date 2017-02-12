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
        
        
        // Connect audio nodes
        if echo == true {
            connectAudioNodes([soundPlayerNode, soundChangeEchoNode, soundEngine.outputNode])
        } else if reverb == true {
            connectAudioNodes([soundPlayerNode, soundChangeReverbNode, soundEngine.outputNode])
        } else {
            connectAudioNodes([soundPlayerNode, soundChangeTimePitchNode, soundEngine.outputNode])
        }
        
        
        // Schedule to play and to start the engine
        soundPlayerNode.stop()
        soundPlayerNode.scheduleFile(soundFile, at: nil) {
            
            var delayInSeconds: Double = 0
            
            if let lastRenderTime = self.soundPlayerNode.lastRenderTime, let playerTime = self.soundPlayerNode.playerTime(forNodeTime: lastRenderTime) {
                
                delayInSeconds = Double(self.soundFile.length - playerTime.sampleTime) / Double(self.soundFile.processingFormat.sampleRate) / Double(rate ?? 1)
            }
            
            self.stopTimer = Timer(timeInterval: delayInSeconds, target: self, selector: #selector(PlaySoundViewController.stopSound), userInfo: nil, repeats: false)
            RunLoop.main.add(self.stopTimer!, forMode: RunLoopMode.defaultRunLoopMode)
        }
        
        do {
            try soundEngine.start()
        } catch {
            showAlert(forVC: self, withTitle: "AudioEngineError", andMessage: "Audio Engine Error!")
        }
        
        
        // Play the recording
        soundPlayerNode.play()
    }
    
    func stopSound() {
        
        // Stop playing sound
        if let soundPlayerNode = soundPlayerNode {
            soundPlayerNode.stop()
        }
        
        
        // Deactivate stop timer and remove it from Run loop
        if let stopTimer = stopTimer {
            stopTimer.invalidate()
        }
        
        
        // Stop & reset audio engine
        if let soundEngine = soundEngine {
            soundEngine.stop()
            soundEngine.reset()
        }
    }
    
    
    // MARK: Aux functions
    
    // Connecting array of audio nodes
    func connectAudioNodes(_ nodes: [AVAudioNode]) {
        for i in 0..<nodes.count-1 {
            soundEngine.connect(nodes[i], to: nodes[i+1], format: soundFile.processingFormat)
        }
    }
}
