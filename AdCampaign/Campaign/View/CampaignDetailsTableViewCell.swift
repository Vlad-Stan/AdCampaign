//
//  CampaignDetailsTableViewCell.swift
//  AdCampaign
//
//  Created by Vlad Stan on 12.10.2023.
//

import UIKit

class CampaignDetailsTableViewCell: UITableViewCell {

    @IBOutlet weak var pricingLabel: UILabel?
    @IBOutlet weak var campaignDetailsLabel: UILabel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    static func classNamedReuseID() -> String {
        return "\(self)"
    }
    
    func configureWith(cellRepresentable: (String, String)) {
        self.pricingLabel?.text = cellRepresentable.0
        self.campaignDetailsLabel?.text = cellRepresentable.1
    }
    
}
