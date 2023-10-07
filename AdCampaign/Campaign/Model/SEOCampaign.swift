//
//  SEOCampaign.swift
//  AdCampaign
//
//  Created by Vlad Stan on 04.10.2023.
//

import Foundation

class SEOCampaign: SocialMediaCampaign {
    var pricingData: Dictionary<String, Any>? {
        return self.dataDict["PricingOptions"] as? Dictionary<String, Any>
    }
}

extension SEOCampaign: PricingOptions {
    func availablePricingOptions() -> [Int] {
        guard let pricingData = self.pricingData else {
            return []
        }
        return pricingData.keys.compactMap { stringKeyValue in
            Int(stringKeyValue)
        }
    }
}

extension SEOCampaign: FeaturesSet {

    func completeFeatureSet() -> Dictionary<String, String>? {
        guard let fullFeatureSet = self.dataDict["Features"] as? Dictionary<String, String> else {
            return nil
        }
        return fullFeatureSet
    }
    
    func featureSet(for pricingValue: Int) -> [String]? {
        guard let validPricingData = self.pricingData,
              let dataForValue = validPricingData[String(pricingValue)] as? Dictionary<String, Any>,
              let featureFlags = dataForValue["FeatureFlag"] as? Array<String>,
              let fullFeatureSet = completeFeatureSet() else {
            return nil
        }
        
        let filteredFeatureSet = fullFeatureSet.filter { element in
            featureFlags.contains(element.key)
        }
        
        let features = filteredFeatureSet.compactMap { element in
            element.value
        }
        return features
    }
    
    
}

