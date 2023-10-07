//
//  AppDelegate.swift
//  AdCampaign
//
//  Created by Vlad Stan on 02.10.2023.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        if let url1 = Bundle.main.url(forResource: "Targeting", withExtension: "plist"),
           let dataDict = DataProvider(dataURL: url1).getLatestData() as? Dictionary<String, String>
        {
            let specifics = DataParser.parseTargetingSpecifics(dataDictionary: dataDict)
            print(specifics)
            
        } else {
            print("Cannot load data")
        }
        
//        if let dataURL = Bundle.main.url(forResource: "Campaigns", withExtension: "plist") {
//            let dataProvider = DataProvider(dataURL: dataURL)
//            let dataDict = dataProvider.getLatestData()
//            DataParser.parse(dataDict: dataDict) { parsedData in
//                for addCampaign in parsedData {
//                    if let facebook = addCampaign as? FacebookMediaCampaign {
//                        print("=================")
//                        print(facebook.targetType)
//                        let pricingOptions = facebook.availablePricingOptions()
//                        let value = pricingOptions.first ?? 0
//                        print("Showing data for pricing value: \(value)")
//                        print(facebook.listings(for: value))
//                        print(facebook.completeFeatureSet())
//                        print(facebook.featureSet(for: value))
//                        print(facebook.optimizations(for: value))
//                    }
//                    if let linkedin = addCampaign as? LinkedInMediaCampaign {
//                        print("=================")
//                        print(linkedin.targetType)
//                    }
//                    if let SEO = addCampaign as? SEOCampaign {
//                        print("=================")
//                        print(addCampaign.targetType)
//                        let pricingOptions = SEO.availablePricingOptions()
//                        let value = pricingOptions.first ?? 0
//                        print("Showing data for pricing value: \(value)")
//                        print(SEO.featureSet(for: value))
//                    }
//                }
//            }
//        }
             
        
        return true
    }
    

    


    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

