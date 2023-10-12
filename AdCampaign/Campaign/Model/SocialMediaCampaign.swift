//
//  SocialMediaCampaign.swift
//  AdCampaign
//
//  Created by Vlad Stan on 02.10.2023.
//

import Foundation

protocol PricingOptions {
    func availablePricingOptions() -> [Int]
}

protocol ListingOptions {
    func listings(for pricingValue: Int) -> String?
}

protocol FeaturesSet {
    func completeFeatureSet() -> Dictionary<String, String>?
    func featureSet(for pricingValue: Int) -> [String]?
}

protocol OptimizationOptions {
    func optimizations(for princingValue: Int) -> String?
}

protocol CellDisplayable {
    func displayRepresentation(pricingOption: Int) -> (String, String)
}

class SocialMediaCampaign: Initable, PricingOptions, ListingOptions, FeaturesSet, OptimizationOptions {
    var targetType: TargetType
    var dataDict: Dictionary<String, Any>
    
    // Pricing options vars
    internal var pricingData: Dictionary<String, Any>? {
        return self.dataDict["PricingOptions"] as? Dictionary<String, Any>
    }
    private var pricingOptions: [Int]?
    
    required init(targetType: TargetType, dataDict: Dictionary<String, Any>) {
        self.targetType = targetType
        self.dataDict = dataDict
        self.loadPricingOptions()
    }

    
    private func loadPricingOptions() {
        guard let pricingData = self.pricingData else {
            return
        }
        self.pricingOptions = pricingData.keys.compactMap { stringKeyValue in
            Int(stringKeyValue)
        }
    }
    
    func availablePricingOptions() -> [Int] {
        return self.pricingOptions ?? []
    }
    
    func listings(for pricingValue: Int) -> String? {
        assert(false, "Implement in subclasses")
        return nil
    }
    
    func completeFeatureSet() -> Dictionary<String, String>? {
        assert(false, "Implement in subclasses")
        return nil
    }
    
    func featureSet(for pricingValue: Int) -> [String]? {
        assert(false, "Implement in subclasses")
        return nil
    }
    
    func optimizations(for princingValue: Int) -> String? {
        assert(false, "Implement in subclasses")
        return nil
    }
}

extension SocialMediaCampaign: CellDisplayable {
    func displayRepresentation(pricingOption: Int) -> (String, String) {
        let prefix = "\(pricingOption) EUR"
        var suffix = ""
        if let listings = self.listings(for: pricingOption) {
            suffix.append(listings)
            suffix.append("\n")
        }
        
        if let optimizations = self.optimizations(for: pricingOption) {
            suffix.append(optimizations)
            suffix.append("\n")
        }
        
        if let featureSet = self.featureSet(for: pricingOption) {
            for item in featureSet {
                suffix.append(item)
                suffix.append("\n")
            }
        }
        
        return (prefix, suffix)
    }
}

// MARK: - Dynamic type creation

protocol Initable {
    init(targetType: TargetType, dataDict: Dictionary<String, Any>)
}

extension SocialMediaCampaign {
    static func subClassTypeBy(targetType: TargetType) -> SocialMediaCampaign.Type {
        switch targetType {
        case .Facebook:
            return FacebookMediaCampaign.self
        case .LinkedIn:
            return LinkedInMediaCampaign.self
        case .SEO:
            return SEOCampaign.self
        case .Twitter:
            return TwitterMediaCampaign.self
        case .Instagram:
            return InstagramMediaCampaign.self
        case .GoogleAdWords:
            return GoogleAdWordsMediaCampaign.self
        }
    }
}
