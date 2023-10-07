//
//  TargetingSpecific.swift
//  AdCampaign
//
//  Created by Vlad Stan on 05.10.2023.
//

import Foundation

class TargetingSpecifics {
    var specific: String
    var platforms: [TargetType]
    
    init(specific: String, platforms: [TargetType]) {
        self.specific = specific
        self.platforms = platforms
    }
}
