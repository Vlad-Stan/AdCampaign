//
//  DataParser.swift
//  AdCampaign
//
//  Created by Vlad Stan on 03.10.2023.
//

import Foundation

typealias ParseResult = ([SocialMediaCampaign]) -> Void

class DataParser {
// MARK: - Parse dict
    static func parse(dataDict: Dictionary<String, Any>, completion: ParseResult) {
        var addCampaigns : [SocialMediaCampaign] = []
        for campaignIdentifier in dataDict.keys {
            let campaingIdentfier = TargetIdentifier(stringLiteral: campaignIdentifier )
            guard let targetType = TargetType(rawValue: campaingIdentfier) else { return }
            guard let campaignData = dataDict[campaignIdentifier] as? Dictionary<String, Any> else {return }
            let campaignClass = SocialMediaCampaign.subClassTypeBy(targetType: targetType)
            let dynamicObject = DataParser.createDynamicType(type: campaignClass, targetType: targetType, data: campaignData)
            addCampaigns.append(dynamicObject)
        }
        completion(addCampaigns)
    }
}

// MARK: - Dynamic Types Object Creation
extension DataParser {
    
    private static func createDynamicType<T:Initable>(type : T.Type, 
                                                      targetType: TargetType,
                                                      data: Dictionary<String, Any>) -> T {
        let type = SocialMediaCampaign.subClassTypeBy(targetType: targetType)
        return type.init(targetType: targetType, dataDict: data) as! T
    }
    
    private static func makeDynamicObject<T: SocialMediaCampaign> (from classType:T.Type,
                                                            targetType: TargetType,
                                                            data: Dictionary<String, Any>) -> T {
        let object = T(targetType: targetType, dataDict: data)
        return object
    }
}

// MARK: - TargetingSpecifics
extension DataParser {
    static func parsePricingOptions(dataDict:Dictionary<String, Any>,
                                    pricingKeyIdentifier: String,
                                    campaignIdentifier:String) {
    }
    
    static func parseTargetingSpecifics(dataDictionary: Dictionary<String, String>) -> [TargetingSpecifics] {
        var specifics: [TargetingSpecifics] = []
        for specificKeyIdentifier in dataDictionary.keys {
            // Only consider valid a non-empty string
            let commaCharSet = CharacterSet(charactersIn: ",")
            
            if let platformsString = dataDictionary[specificKeyIdentifier], platformsString.count > 0,
               let platforms = DataParser.parsePlatforms(from: platformsString, separator: commaCharSet) {
                let targetingSpecific = TargetingSpecifics(specific: specificKeyIdentifier, platforms: platforms)
                specifics.append(targetingSpecific)
            }
        }
        return specifics
    }
    
    static func parsePlatforms(from stringValue: String, separator: CharacterSet) -> [TargetType]? {
        let componets = stringValue.components(separatedBy: separator)
        var result: [TargetType] = []
        for campaignIdentifier in componets {
            let campaingIdentfier = TargetIdentifier(stringLiteral: campaignIdentifier )
            if let campaign = TargetType(rawValue: campaingIdentfier) {
                result.append(campaign)
            } else {
//                print("Invalid Campaign Identifier: [\(campaignIdentifier)]. Define a new type in TargetType.swift")
            }
        }
        return result.count > 0 ? result : nil
    }
}
