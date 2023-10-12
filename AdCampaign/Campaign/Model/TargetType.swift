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

enum TargetType: TargetIdentifier {
    case Facebook = "Facebook"
    case SEO = "SEO"
    case LinkedIn = "Linkedin"
    case Twitter = "Twitter"
    case Instagram = "Instagram"
    case GoogleAdWords = "Google AdWords"
}
