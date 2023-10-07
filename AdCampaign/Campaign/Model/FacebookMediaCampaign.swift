//
//  FacebookMediaCampaign.swift
//  AdCampaign
//
//  Created by Vlad Stan on 03.10.2023.
//

import Foundation

class FacebookMediaCampaign: SocialMediaCampaign {
    var pricingData: Dictionary<String, Any>? {
        return self.dataDict["PricingOptions"] as? Dictionary<String, Any>
    }
    
    required init(targetType: TargetType, dataDict: Dictionary<String, Any>) {
        super.init(targetType: targetType, dataDict: dataDict)
    }
}

extension FacebookMediaCampaign: PricingOptions {
    
    func availablePricingOptions() -> [Int] {
        guard let pricingData = self.pricingData else {
            return []
        }
        return pricingData.keys.compactMap { stringKeyValue in
            Int(stringKeyValue)
        }
    }
}

extension FacebookMediaCampaign: ListingOptions {

    func listings(for pricingValue: Int) -> String? {
        
        guard let pricingData = self.pricingData,
              let pricingValue = pricingData[String(pricingValue)] as? Dictionary<String, Any>,
              let listings = pricingValue["Listings"] as? String else {
            return nil
        }
        
        return listings
    }
}

extension FacebookMediaCampaign: FeaturesSet {
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

extension FacebookMediaCampaign: OptimizationOptions {
    func optimizations(for princingValue: Int) -> String? {
        guard let validPricingData = self.pricingData,
              let dataForValue = validPricingData[String(princingValue)] as? Dictionary<String, Any>,
              let optimzation = dataForValue["Optimizations"] as? String else {
            return nil
        }
        return optimzation
        
    }
}
