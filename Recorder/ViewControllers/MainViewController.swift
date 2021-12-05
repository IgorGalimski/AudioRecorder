//
//  ViewController.swift
//  Recorder
//
//  Created by IgorGalimski on 04/12/2021.
//

import UIKit
import AVFoundation

class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource
{
    @IBOutlet weak var addRecording: UIButton!
    @IBOutlet weak var dataTableView: UITableView!
    
    var player: AVAudioPlayer?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        SetupUserInterface()
        SetupTableView()
    }

    func SetupUserInterface()
    {
        navigationController?.navigationBar.barTintColor = UIColor(named: "barTint")
        
        CoreDataService.Shared.LoadCoreData()
    }
    
    func SetupTableView()
    {
        UITableView.appearance().backgroundColor = .clear
        UITableViewCell.appearance().backgroundColor = .clear
        
        dataTableView.delegate = self
        dataTableView.delegate = self
        dataTableView.register(UINib(nibName: "RecordingCell", bundle: Bundle.main), forCellReuseIdentifier: "Cell")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return CoreDataService.Shared.NumberOfItems()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! RecordingCell
        
        if indexPath.row % 2 == 0
        {
            cell.contentView.backgroundColor = UIColor(named: "cellEven")
        }
        else
        {
            cell.contentView.backgroundColor = UIColor(named: "cellUnEven")
        }
        
        let currentObject = CoreDataService.Shared.recordedData[indexPath.row]
        
        cell.titleLabel.text = currentObject.title
        cell.dateLabel.text = CorrectFormat(currentObject.date!)
        cell.playButton.tag = indexPath.row
        cell.playButtonClosure =
        {
            [unowned self] in
            do
            {
                self.player = try AVAudioPlayer(data: currentObject.audioData!)
                self.player?.play()
            }
            catch let error
            {
                print(error)
            }
        }
        
        return cell
    }
    
    private func CorrectFormat(_ date: Date) -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .short
        return dateFormatter.string(from: date)
    }
}

