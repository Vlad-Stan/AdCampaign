//
//  TargetingSpecificViewModel.swift
//  AdCampaign
//
//  Created by Vlad Stan on 10.10.2023.
//

import Foundation

protocol DataUpdate: AnyObject {
    func didUpdateData(error: NSError?)
}

class TargetingSpecificViewModel {
    var dataProvider: DataProvider
    weak var dataUpdateDelegate: DataUpdate?
    
    private var dataSource: [TargetingSpecifics]?
    private var selectedSpecifics: [TargetingSpecifics]?

    init(dataProvider: DataProvider, dataUpdateDelegate: DataUpdate? = nil) {
        self.dataProvider = dataProvider
        self.dataUpdateDelegate = dataUpdateDelegate
    }

    
    func updateData() {
        guard let dataDict = self.dataProvider.getLatestData() as? Dictionary<String, String> else {
            let error = NSError(domain: "DataUdpateErrorDomain", code: 0, userInfo: [NSLocalizedDescriptionKey: "Data update error"])
            self.dataUpdateDelegate?.didUpdateData(error: error)
            return
        }
        let specifics = DataParser.parseTargetingSpecifics(dataDictionary: dataDict)
        self.dataSource = specifics
        self.dataUpdateDelegate?.didUpdateData(error: nil)
    }
    
    func cachedData()-> [TargetingSpecifics]? {
        return self.dataSource
    }
    
    func selectedOptions() -> [TargetingSpecifics]? {
        return self.selectedSpecifics
    }
    
    func udpateSelectionWith(target: TargetingSpecifics) {
        if self.selectedSpecifics == nil {
            self.selectedSpecifics = []
        }
        if let alreadySelectedIndex = self.selectedSpecifics?.firstIndex(of: target) {
            self.selectedSpecifics?.remove(at: alreadySelectedIndex)
        } else {
            self.selectedSpecifics?.append(target)
        }
    }
    
    func isSelected(target: TargetingSpecifics) -> Bool {
        return (self.selectedSpecifics?.firstIndex(of: target) != nil)
    }
}
