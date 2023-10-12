//
//  SEOCampaign.swift
//  AdCampaign
//
//  Created by Vlad Stan on 04.10.2023.
//

import Foundation

class SEOCampaign: SocialMediaCampaign {
    
// MARK: - ListingOptions override
    override func listings(for pricingValue: Int) -> String? {
        return nil
    }
    
// MARK: - OptimizationOptions override
    override func optimizations(for princingValue: Int) -> String? {
        return nil
    }

// MARK: - Feature Set override
    override func completeFeatureSet() -> Dictionary<String, String>? {
        guard let fullFeatureSet = self.dataDict["Features"] as? Dictionary<String, String> else {
            return nil
        }
        return fullFeatureSet
    }
    
    override func featureSet(for pricingValue: Int) -> [String]? {
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
