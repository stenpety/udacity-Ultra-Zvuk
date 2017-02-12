//
//  PlaySoundViewController.swift
//  UltraZvuk
//
//  Created by Petr Stenin on 11/02/2017.
//  Copyright © 2017 Petr Stenin. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundViewController: UIViewController, AlertsForUltraZvuk {
    
    //MARK: Properties, outlets, enums
    
    // Properties to handle audio stuff
    var recordedSoundURL: URL!
    var soundFile: AVAudioFile!
    var soundEngine: AVAudioEngine!
    var soundPlayerNode: AVAudioPlayerNode!
    var stopTimer: Timer!
    
    
    //Outlets for buttons
    @IBOutlet weak var playSoundSlowButton: UIButton!
    @IBOutlet weak var playSoundFastButton: UIButton!
    @IBOutlet weak var playSoundHighPitchButton: UIButton!
    @IBOutlet weak var playSoundLowPitchButton: UIButton!
    @IBOutlet weak var playSoundEchoButton: UIButton!
    @IBOutlet weak var playSoundReverbButton: UIButton!
    @IBOutlet weak var stopPlaySoundButton: UIButton!
    
    
    //Aux enums
    enum ButtonType: Int {
        case slow = 0, fast, chipmunk, vader, echo, reverb
    }
    
    
    
    //MARK: Initial setup
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAudio()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        playUISetup(forState: .notPlaying)
    }
    
    
    
    //MARK: Actions
    
    @IBAction func playSoundForButton(_ sender: UIButton) {
        playUISetup(forState: .playing)
        
        switch ButtonType(rawValue: sender.tag)! {
        case .slow:
            playSound(rate: 0.25)
        case .fast:
            playSound(rate: 2.5)
        case .chipmunk:
            playSound(pitch: 1000)
        case .vader:
            playSound(pitch: -1000)
        case .echo:
            playSound(echo: true)
        case .reverb:
            playSound(reverb: true)
        }
    }
    
    
    @IBAction func stopPlaySound(_ sender: Any) {
        playUISetup(forState: .notPlaying)
        stopSound()
    }
    
    
    
    //MARK: UI setup
    
    enum playState {
        case playing, notPlaying
    }
    
    func playUISetup(forState state: playState) {
        let playButtons = [playSoundSlowButton, playSoundFastButton, playSoundHighPitchButton, playSoundLowPitchButton, playSoundEchoButton, playSoundReverbButton]
        for buttonOutlet in playButtons {buttonOutlet?.isEnabled = (state == .notPlaying)}
        stopPlaySoundButton.isEnabled = (state == .playing)
    }
    
    

    
    
    
    
    
}
