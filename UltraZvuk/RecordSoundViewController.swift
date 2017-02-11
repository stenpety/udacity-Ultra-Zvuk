//
//  ViewController.swift
//  UltraZvuk
//
//  Created by Petr Stenin on 11/02/2017.
//  Copyright © 2017 Petr Stenin. All rights reserved.
//

import UIKit
import AVFoundation

class RecordSoundViewController: UIViewController, AVAudioRecorderDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        recordUISetup(forState: .notRecording)
    }
    
    //MARK: Outlets for buttons/label
    
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var stopRecordButton: UIButton!
    @IBOutlet weak var recordStatusLabel: UILabel!
    
    
    
    //MARK: Actions
    
    @IBAction func recordSound(_ sender: Any) {
        recordUISetup(forState: .recording)
        
        
    }
    
    @IBAction func stopRecordSound(_ sender: Any) {
        recordUISetup(forState: .notRecording)
    }
    
    
    //MARK: UI configuration
    enum recordState {
        case recording, notRecording
    }
    
    func recordUISetup(forState state: recordState) {
        recordButton.isEnabled = (state == .notRecording)
        stopRecordButton.isEnabled = (state == .recording)
        recordStatusLabel.text = (state == .recording ? "Record in progress" : "Tap to record")
    }
    
    
}

