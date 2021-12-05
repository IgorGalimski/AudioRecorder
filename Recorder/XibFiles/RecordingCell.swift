//
//  RecordingCell.swift
//  Recorder
//
//  Created by IgorGalimski on 04/12/2021.
//

import UIKit

class RecordingCell: UITableViewCell
{
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var playButton: UIButton!
    
    var playButtonClosure: (() -> ())?
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        
        playButton.addTarget(self, action: #selector(PlayButtonWasTapped), for: .touchUpInside)
        
        playButton.SetupFSsymbol(imageName: "chevron.right.circle", fontSize: 45)
    }
    
    @objc func PlayButtonWasTapped()
    {
        playButtonClosure?()
    }

    override func setSelected(_ selected: Bool, animated: Bool)
    {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
