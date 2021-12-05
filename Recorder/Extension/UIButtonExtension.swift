//
//  UIButtonExtension.swift
//  Recorder
//
//  Created by IgorGalimski on 05/12/2021.
//

import UIKit

extension UIButton
{
    open override func awakeFromNib()
    {
        super.awakeFromNib()
        
        self.layer.cornerRadius = self.frame.height / 2
    }
    
    func SetupFSsymbol(imageName: String, fontSize: CGFloat)
    {
        guard let image = UIImage(systemName: imageName) else { return }
        
        let symbolConfiguration = UIImage.SymbolConfiguration(pointSize: fontSize, weight: .ultraLight)
        
        setPreferredSymbolConfiguration(symbolConfiguration, forImageIn: .normal)
        
        setImage(image, for: .normal)
    }
}
