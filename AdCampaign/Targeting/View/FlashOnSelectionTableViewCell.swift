//
//  FlashOnSelectionTableViewCell.swift
//  AdCampaign
//
//  Created by Vlad Stan on 10.10.2023.
//

import UIKit

class FlashOnSelectionTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
        if selected {
            self.flashBackgroundColor()
        }
    }
    
    private func flashBackgroundColor() {
        let originalColor = contentView.backgroundColor ?? UIColor.clear
        let flashColor = UIColor.lightGray

        let colorAnimation = CABasicAnimation(keyPath: "backgroundColor")
        colorAnimation.fromValue = originalColor.cgColor
        colorAnimation.toValue = flashColor.cgColor
        colorAnimation.duration = 0.1
        colorAnimation.autoreverses = true
        // Set the final background color
        contentView.backgroundColor = flashColor
        // Add the animation to the content view's layer
        contentView.layer.add(colorAnimation, forKey: "backgroundColorFlashAnimation")
        // Use UIView.animate to reset the background color after the animation completes
        DispatchQueue.main.asyncAfter(deadline: .now() + colorAnimation.duration) {
            UIView.animate(withDuration: colorAnimation.duration) {
                self.contentView.backgroundColor = originalColor
            }
        }
    }

}
