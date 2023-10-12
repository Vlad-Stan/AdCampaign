//
//  CampaignType.swift
//  AdCampaign
//
//  Created by Vlad Stan on 03.10.2023.
//

import Foundation

struct TargetIdentifier: Equatable, ExpressibleByStringLiteral {
    var name: String
    init(stringLiteral value: StringLiteralType) {
        name = value
    }
}

enum TargetType: TargetIdentifier, Codable {
    case Facebook = "Facebook"
    case SEO = "SEO"
    case LinkedIn = "Linkedin"
    case Twitter = "Twitter"
    case Instagram = "Instagram"
    case GoogleAdWords = "Google AdWords"
}

//class TestVlad {
//    
//    static func testEncoding() {
//        let facebookTarget: TargetType = .Facebook
//        
//        let jsonEncoder = JSONEncoder()
//        if let jsonData = try? jsonEncoder.encode(facebookTarget) {
//            if let jsonString = String(data: jsonData, encoding: .utf8) {
//                print(jsonString)
//            }
//        }
//    }
//    
//    static func testDecoding() {
//        let json = "{\"Twitter\":{}}"
//
//        let jsonDecoder = JSONDecoder()
//        do {
//            let decodedTarget = try jsonDecoder.decode(TargetType.self, from: json.data(using: .utf8)!)
//            print(decodedTarget.rawValue.name) // This will print "Twitter"
//        } catch {
//            print("Error decoding JSON: \(error)")
//        }
//    }
//}
