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
    
    //MARK: Initial view setup
    
    override func viewDidLoad() {
        super.viewDidLoad()
        recordUISetup(forState: .notRecording)
    }
    
    
    
    //MARK: Outlets for buttons/label
    
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var stopRecordButton: UIButton!
    @IBOutlet weak var recordStatusLabel: UILabel!
    
    
    // Init an instance of AVAudioRecorder
    var soundRecorder: AVAudioRecorder!
    
    
    //MARK: Actions
    
    @IBAction func recordSound(_ sender: Any) {
        // Setuo UI for Recording state
        recordUISetup(forState: .recording)
        
        // Define an URL for recorded audio file
        let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
        let soundFilePath = URL(string: dirPath + "/recordedSound.wav")
        
        // Initialize and setup audio session (play & record, build-in speaker in use)
        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(AVAudioSessionCategoryPlayAndRecord, with: .defaultToSpeaker)
        
        // Setup soundRecorder and start to record sound
        try! soundRecorder = AVAudioRecorder(url: soundFilePath!, settings: [:])
        
        soundRecorder.delegate = self // Set RecordSoundVC to be delegate of AudioRecorder
        
        soundRecorder.isMeteringEnabled = true
        soundRecorder.prepareToRecord()
        soundRecorder.record()
    }
    
    @IBAction func stopRecordSound(_ sender: Any) {
        // Setup UI for non-recording state
        recordUISetup(forState: .notRecording)
        
        // Stop recording
        soundRecorder.stop()
        
        // Deactivate a singleton audio session
        let audioSession = AVAudioSession.sharedInstance()
        try! audioSession.setActive(false)
    }
    
    
    
    //MARK: Delegate functions
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if flag {
            performSegue(withIdentifier: "segueToPlaySoundVC", sender: soundRecorder.url)
        } else {
            showAlert(withTitle: "Warning!", andMessage: "Recording was NOT successful")
        }
    }
    
    
    
    //MARK: Prepare for segue to PlaySoundVC
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueToPlaySoundVC" {
            let playSoundVC = segue.destination as! PlaySoundViewController // Forced downcast from any VC to a specific VC
            playSoundVC.recordedSoundURL = (sender as! URL) // Forced downcast from Any? to URL
        }
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
    
    func showAlert(withTitle title: String, andMessage message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    
}

