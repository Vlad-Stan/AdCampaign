//
//  DataProvider.swift
//  AdCampaign
//
//  Created by Vlad Stan on 03.10.2023.
//

import Foundation

protocol AvailableData {
    func getLatestData() -> Dictionary<String, Any>
}

class DataProvider {
    var dataURL: URL
    
    init(dataURL: URL) {
        self.dataURL = dataURL
    }
    
    func loadLocalURL(localURL: URL) -> Dictionary<String, Any> {
        let pathExtension = localURL.pathExtension
        let fileName = localURL.deletingPathExtension().lastPathComponent
        return self.loadDataDictionary(from: fileName, fileType: pathExtension) ?? [:]
    }
    
    private func loadDataDictionary(from filePath: String, fileType: String) -> Dictionary<String, Any>? {
        guard let path = Bundle.main.path(forResource: filePath, ofType: fileType) else { return nil }
        guard let dataDict = NSDictionary(contentsOfFile: path) as? Dictionary<String, Any> else { return nil}
        return dataDict
    }
}

extension DataProvider: AvailableData {
    func getLatestData() -> Dictionary<String, Any> {
        self.loadLocalURL(localURL: self.dataURL)
    }

}
