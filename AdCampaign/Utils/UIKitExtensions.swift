//
//  Extensions.swift
//  AdCampaign
//
//  Created by Vlad Stan on 09.10.2023.
//

import Foundation
import UIKit

// MARK: - Animations
extension UIView {
    func animateBackgroundColorChange(to targetColor: UIColor, duration: TimeInterval = 0.8) {
        let originalColor = self.backgroundColor ?? UIColor.clear
        
        // Create a CABasicAnimation to animate the background color
        let colorAnimation = CABasicAnimation(keyPath: "backgroundColor")
        colorAnimation.fromValue = originalColor.cgColor
        colorAnimation.toValue = targetColor.cgColor
        colorAnimation.duration = duration
        colorAnimation.autoreverses = true // Automatically reverses the animation
        
        // Update the view's background color to the target color
        self.backgroundColor = targetColor
        
        // Add the animation to the view's layer
        self.layer.add(colorAnimation, forKey: "backgroundColorAnimation")
    }
}
