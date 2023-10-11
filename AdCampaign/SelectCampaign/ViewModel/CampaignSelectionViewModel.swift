//
//  CampaignSelectionViewModel.swift
//  AdCampaign
//
//  Created by Vlad Stan on 11.10.2023.
//

import Foundation

class CampaignSelectionViewModel {
    private var dataSource: [TargetType]
    
    init(dataSource: [TargetType]) {
        self.dataSource = dataSource
    }
    
    func availablePlatforms() -> [TargetType] {
        return self.dataSource
    }
    
    func dataSourceDescription() -> String {
        if self.dataSource.count == 0 {
            return "No platforms available."
        } else {
            let prefix = self.dataSource.count == 1 ? "One platform available." : "\(self.dataSource.count) platforms available."
            let suffix = self.dataSource.count == 1 ? "Select it to view pricing options." : "Select one to view pricing options."
            let formattedString = "\(prefix) \(suffix)"
            return formattedString
        }
    }
}
