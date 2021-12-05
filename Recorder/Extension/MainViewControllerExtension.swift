//
//  MainViewControllerExtension.swift
//  Recorder
//
//  Created by IgorGalimski on 05/12/2021.
//

import UIKit

extension MainViewController
{
    func HandleRecordingButton()
    {
        if CoreDataService.Shared.NumberOfItems() == 0
        {
            addRecording.SetupFSsymbol(imageName: "plus", fontSize: 50)
            addRecording.addTarget(self, action: #selector(AddButtonAction), for: .touchUpInside)
            addRecording.alpha = .zero
            addRecording.transform = CGAffineTransform(translationX: .zero, y: 30)
            
            dataTableView.isHidden = true
            
            UIView.animate(withDuration: 1.8, delay: .zero, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.25, options: .curveEaseOut, animations: { [self] in
                
                self.addRecording.isHidden = false
                self.addRecording.transform = CGAffineTransform(translationX: .zero, y: .zero)
                self.addRecording.alpha = 1.0
                
            }, completion: nil)
        }
        else
        {
            addRecording.isHidden = true
            dataTableView.isHidden = false
        }
    }
    
    @objc func AddButtonAction()
    {
        performSegue(withIdentifier: "RecorderView", sender: nil)
    }
}
