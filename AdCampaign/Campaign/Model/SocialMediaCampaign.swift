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

class SocialMediaCampaign: Initable {
    var targetType: TargetType
    var dataDict: Dictionary<String, Any>
    
    required init(targetType: TargetType, dataDict: Dictionary<String, Any>) {
        self.targetType = targetType
        self.dataDict = dataDict
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
        }
    }
}
