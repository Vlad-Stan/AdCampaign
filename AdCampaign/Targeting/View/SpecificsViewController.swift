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
    
    private unowned var footerView: FooterView?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.setupTableView()
        self.setupFooterView()
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
    
    private func setupFooterView() {
        let footerView = FooterView.instanceFromNib()
        footerView.frame = CGRect(origin: .zero, size: CGSize(width: self.view.frame.size.width, height: 100))
        footerView.actionButtonDelegate = self
        let enabled = self.viewModel?.selectedOptions()?.count ?? 0 > 0
        footerView.toggleEnabled(isEnabled: enabled)
        footerView.actionButton?.setTitle("View Selected Campaigns", for: .normal)
        self.tableView?.tableFooterView = footerView
        self.footerView = footerView
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
        let enabled = self.viewModel?.selectedOptions()?.count ?? 0 > 0
        self.footerView?.toggleEnabled(isEnabled: enabled)
        tableView.reloadRows(at: [indexPath], with: .automatic)
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
            return cell
        }
        let selected = self.viewModel?.isSelected(target: specific) ?? false
        cell.configureWith(specific: specific, isSelected: selected)
        
        return cell
    }
}

extension SpecificsViewController: ActionCallback {
    func buttonPressed() {
        guard let selectedSpecifics = self.viewModel?.selectedOptions() else { return }
        var combinedPlatforms: [TargetType] = []
        for specific in selectedSpecifics {
            combinedPlatforms.append(contentsOf: specific.platforms)
        }
        let distinctPlatforms = Set<TargetType>(combinedPlatforms)
    }
}
