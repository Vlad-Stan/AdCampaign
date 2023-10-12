//
//  InstagramMediaCampaign.swift
//  AdCampaign
//
//  Created by Vlad Stan on 12.10.2023.
//

import Foundation

class InstagramMediaCampaign: SocialMediaCampaign {

    // MARK: - ListingOptions override
    override func listings(for pricingValue: Int) -> String? {
        
        guard let pricingData = self.pricingData,
              let pricingValue = pricingData[String(pricingValue)] as? Dictionary<String, Any>,
              let listings = pricingValue["Listings"] as? String else {
            return nil
        }
        return listings
    }
    
    // MARK: - OptimizationOptions override
    override func optimizations(for princingValue: Int) -> String? {
        guard let validPricingData = self.pricingData,
              let dataForValue = validPricingData[String(princingValue)] as? Dictionary<String, Any>,
              let optimzation = dataForValue["Optimizations"] as? String else {
            return nil
        }
        return optimzation
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
