//
//  BG.swift
//  SlimMiniProjet
//
//  Created by ESPRIT on 25/11/2019.
//  Copyright © 2019 ESPRIT. All rights reserved.
//
import Foundation

import UIKit


extension UIView {

    func bg(colorone:UIColor,colorTwo:UIColor){
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = [colorone.cgColor,colorTwo.cgColor]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.startPoint = CGPoint(x: 1.0, y: 1.0)
        gradientLayer.endPoint = CGPoint(x: 0.0, y: 0.0)
        layer.insertSublayer(gradientLayer, at: 0)
        
    }
    
}
