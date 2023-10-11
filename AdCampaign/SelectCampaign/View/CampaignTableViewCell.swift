//
//  CampaignTableViewCell.swift
//  AdCampaign
//
//  Created by Vlad Stan on 11.10.2023.
//

import UIKit

class CampaignTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(targetType: TargetType) {
        self.textLabel?.text = targetType.rawValue.name
    }
}
