//
//  PlaySoundViewController.swift
//  UltraZvuk
//
//  Created by Petr Stenin on 11/02/2017.
//  Copyright © 2017 Petr Stenin. All rights reserved.
//

import UIKit

class PlaySoundViewController: UIViewController {
    
    //MARK: Outlets for buttons
    
    @IBOutlet weak var playSoundSlowButton: UIButton!
    @IBOutlet weak var playSoundFastButton: UIButton!
    @IBOutlet weak var playSoundHighPitchButton: UIButton!
    @IBOutlet weak var playSoundLowPitchButton: UIButton!
    @IBOutlet weak var playSoundEchoButton: UIButton!
    @IBOutlet weak var playSoundReverbButton: UIButton!
    @IBOutlet weak var stopPlaySoundButton: UIButton!
    
    
    
    //MARK: Initial view setup
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        playUISetup(forState: .notPlaying)
    }
    
    
    
    //MARK: Actions
    
    @IBAction func playSoundForButton(_ sender: Any) {
        playUISetup(forState: .playing)
    }
    
    @IBAction func stopPlaySound(_ sender: Any) {
        playUISetup(forState: .notPlaying)
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
