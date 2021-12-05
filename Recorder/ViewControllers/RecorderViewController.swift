//
//  RecorderViewController.swift
//  Recorder
//
//  Created by IgorGalimski on 04/12/2021.
//

import UIKit
import AVFoundation

class RecorderViewController: UIViewController
{
    private var isRecording: Bool = false

    @IBOutlet weak var recorderLabel: UILabel!
    @IBOutlet weak var recordButton: UIButton!
    @IBAction func recordButtonPressed(_ sender: Any)
    {
        StopAndSaveRecording()
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        StartRecording()
    }
    
    override func viewDidDisappear(_ animated: Bool)
    {
        super.viewDidDisappear(animated)
        
        if isRecording
        {
            StopAndSaveRecording()
        }
    }
    
    func StartRecording()
    {
        isRecording = true
        
        switch AVAudioSession.sharedInstance().recordPermission
        {
            case .undetermined: AVAudioSession.sharedInstance().requestRecordPermission
            { _ in
                
            }
            case .denied: recorderLabel.text = "Microphone access was denied"
            case .granted: break
            default: break
        }
        
        AudioRecorder.Shared.StartRecording()
        
        recordButton.SetupFSsymbol(imageName: "stop.fill", fontSize: 100)
        recorderLabel.text = "Recording"
    }
    
    func StopAndSaveRecording()
    {
        isRecording = false
        
        let recordedObject = Recorded(context: CoreDataService.Shared.AppViewContext())
        recordedObject.title = "Record \(CoreDataService.Shared.NumberOfItems())"
        recordedObject.date = Date()
        recordedObject.audioData = AudioRecorder.Shared.StopRecording()
        
        CoreDataService.Shared.Save()
        
        dismiss(animated: true, completion: nil)
    }
}
