//
//  PlaySoundViewController.swift
//  UltraZvuk
//
//  Created by Petr Stenin on 11/02/2017.
//  Copyright © 2017 Petr Stenin. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundViewController: UIViewController {
    
    //MARK: Properties, outlets, enums, constants
    
    // Properties to handle audio stuff
    var recordedSoundURL: URL!
    var soundFile: AVAudioFile!
    var soundEngine: AVAudioEngine!
    var soundPlayerNode: AVAudioPlayerNode!
    var stopTimer: Timer!
    
    // Outlets for buttons
    @IBOutlet weak var playSoundSlowButton: UIButton!
    @IBOutlet weak var playSoundFastButton: UIButton!
    @IBOutlet weak var playSoundHighPitchButton: UIButton!
    @IBOutlet weak var playSoundLowPitchButton: UIButton!
    @IBOutlet weak var playSoundEchoButton: UIButton!
    @IBOutlet weak var playSoundReverbButton: UIButton!
    @IBOutlet weak var stopPlaySoundButton: UIButton!
    
    // Aux enums
    enum ButtonType: Int {
        case slow = 0, fast, chipmunk, vader, echo, reverb
    }
    
    // Class constants for adjusting audio
    static let SOUND_LOW_RATE: Float = 0.25
    static let SOUND_HIGH_RATE: Float = 2.0
    static let SOUND_LOW_PITCH: Float = -1000
    static let SOUND_HIGH_PITCH: Float = 1000
    
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
            playSound(rate: PlaySoundViewController.SOUND_LOW_RATE)
        case .fast:
            playSound(rate: PlaySoundViewController.SOUND_HIGH_RATE)
        case .chipmunk:
            playSound(pitch: PlaySoundViewController.SOUND_HIGH_PITCH)
        case .vader:
            playSound(pitch: PlaySoundViewController.SOUND_LOW_PITCH)
        case .echo:
            playSound(echo: true)
        case .reverb:
            playSound(reverb: true)
        }
    }
    
    @IBAction func stopPlaySound(_ sender: Any) {
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
