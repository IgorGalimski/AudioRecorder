//
//  AudioRecorded.swift
//  Recorder
//
//  Created by IgorGalimski on 04/12/2021.
//

import UIKit
import AVFoundation

class AudioRecorder
{
    static var Shared = AudioRecorder()
    
    private var audioRecorder: AVAudioRecorder!
    
    var recordingSettings: [String: Int] = [AVSampleRateKey: 12000, AVFormatIDKey: Int(kAudioFormatMPEG4AAC), AVNumberOfChannelsKey: 2, AVEncoderAudioQualityKey: AVAudioQuality.medium.rawValue]
    
    private var recordingSession: AVAudioSession?
    
    private var recordedTrack: Data?
    
    init()
    {
        SetupAudioRecorder()
    }

    func SetupAudioRecorder()
    {
        recordingSession = AVAudioSession.sharedInstance()
        
        do
        {
            try recordingSession!.setCategory(.playAndRecord, mode: .spokenAudio, options: .defaultToSpeaker)
            try audioRecorder = AVAudioRecorder(url: recordingUrl(), settings: recordingSettings)
        }
        catch let error
        {
            print(error)
        }
    }
    
    private func recordingUrl() -> URL
    {
        let fileManager = FileManager.default
        let urls = fileManager.urls(for: .documentDirectory, in: .userDomainMask)
        let documentDirectory = urls[0] as NSURL
        documentDirectory.removeAllCachedResourceValues()
        
        let recordingUrl = documentDirectory.appendingPathComponent("audio")
        
        return recordingUrl!
    }
    
    private func StartRecording()
    {
        recordingSession = AVAudioSession.sharedInstance()
        
        do
        {
            if let session = recordingSession
            {
                try session.setActive(true)
                audioRecorder.record()
            }
        }
        catch let error
        {
            print(error)
        }
    }
    
    private func StopRecording()
    {
        audioRecorder.stop()
        
        do
        {
            if let session = recordingSession
            {
                try session.setActive(true)
            }
        }
        catch let error
        {
            print(error)
        }
        
        var audioTrack: Data?
        
        do
        {
            audioTrack = try Data(contentsOf: audioRecorder.url)
        }
        catch let error
        {
            print(error)
        }
        
        if let track = audioTrack
        {
            recordedTrack = track
        }
    }
}


