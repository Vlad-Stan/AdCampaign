//
//  SpecificsViewController.swift
//  AdCampaign
//
//  Created by Vlad Stan on 07.10.2023.
//

import UIKit

class SpecificsViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView?
    var viewModel: TargetingSpecificViewModel?
    
        
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.setupTableView()
        self.title = "Targeting Specifics"
        self.loadInitialData()
    }
        
    private func setupTableView() {
        
        let reuseId = TargetingTableViewCell.classNamedReuseID()
        let nib = UINib(nibName: "TargetingTableViewCell", bundle:nil)
        self.tableView?.register(nib, forCellReuseIdentifier: reuseId)
        self.tableView?.rowHeight = UITableView.automaticDimension
        self.tableView?.estimatedRowHeight = 50
    }
    
    func loadInitialData() {
        if self.viewModel == nil,
           let url = Bundle.main.url(forResource: "Targeting", withExtension: "plist") {
            let dataProvider = DataProvider(dataURL: url)
            self.viewModel = TargetingSpecificViewModel(dataProvider: dataProvider, dataUpdateDelegate: self)
        }
        self.viewModel?.updateData()
    }
}

extension SpecificsViewController: DataUpdate {
    func didUpdateData(error: NSError?) {
        self.tableView?.reloadData()
    }
}

extension SpecificsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let specific = self.viewModel?.cachedData()?[indexPath.row] as? TargetingSpecifics else { return }
        self.viewModel?.udpateSelectionWith(target: specific)
    }
}

extension SpecificsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel?.cachedData()?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let reuseID = TargetingTableViewCell.classNamedReuseID()
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseID , for: indexPath) as! TargetingTableViewCell
        guard let specific = self.viewModel?.cachedData()?[indexPath.row] as? TargetingSpecifics else {
            return cell // Empty cell - should not be the case
        }
        cell.configureWith(specific: specific)
        
        return cell
    }
}
