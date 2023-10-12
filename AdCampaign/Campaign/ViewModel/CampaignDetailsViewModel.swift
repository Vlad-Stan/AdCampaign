//
//  CampaignDetailsViewModel.swift
//  AdCampaign
//
//  Created by Vlad Stan on 11.10.2023.
//

import Foundation

protocol DataUpdateDelegate: AnyObject {
    func didUpdateCampaignData()
}

class CampaignDetailsViewModel {
    var dataProvider: DataProvider
    weak var dataDelegate: DataUpdateDelegate?
    var selectedCampaign: TargetType?
    
    private var dataSource: [SocialMediaCampaign]?
    
    init(dataProvider: DataProvider, dataDelegate: DataUpdateDelegate? = nil) {
        self.dataProvider = dataProvider
        self.dataDelegate = dataDelegate
    }
    
    func updateData() {
        let dataDict = self.dataProvider.getLatestData()
        DataParser.parse(dataDict: dataDict) { parsedData in
            self.dataSource = parsedData
            self.dataDelegate?.didUpdateCampaignData()
        }
    }
    
    func campaignDetailsForSelection(type:TargetType) -> SocialMediaCampaign? {
        var campaignData: SocialMediaCampaign? = nil
        
        guard let filtered = self.dataSource?.filter({ element in
            element.targetType == type
        }).first as? SocialMediaCampaign else {
            print("Did not find campaing details for platform \(type)")
            return campaignData
        }
        campaignData = filtered
        
        return campaignData
    }
}
