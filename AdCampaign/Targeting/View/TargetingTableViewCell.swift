//
//  TargetingTableViewCell.swift
//  AdCampaign
//
//  Created by Vlad Stan on 10.10.2023.
//

import UIKit

class TargetingTableViewCell: FlashOnSelectionTableViewCell {

    @IBOutlet var targetingLabel: UILabel?
    @IBOutlet var platformsLabel: UILabel?
    @IBOutlet var selectedImageView: UIImageView?
    
    func configure(content: [String]) {
        self.targetingLabel?.text = content.first
        self.platformsLabel?.text = content.joined(separator: "\n")
    }
    
    static func classNamedReuseID() -> String {
        return "\(self)"
    }
    
    func configureWith(specific: TargetingSpecifics) {
        self.targetingLabel?.text = specific.specific
        let strings = specific.platforms.map { element in
            "\(element)"
        }
        self.platformsLabel?.text = strings.joined(separator: "\n")
    }

}
