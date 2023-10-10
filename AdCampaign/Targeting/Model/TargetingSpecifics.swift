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

extension TargetingSpecifics: Hashable {
    static func == (lhs: TargetingSpecifics, rhs: TargetingSpecifics) -> Bool {
        let elementsEqual = lhs.platforms.elementsEqual(rhs.platforms)
        let nameEqual = lhs.specific.caseInsensitiveCompare(rhs.specific) == .orderedSame
        return elementsEqual && nameEqual
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(specific)
        hasher.combine(platforms)
    }
}
