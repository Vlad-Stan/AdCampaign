//
//  SelectCampaignViewController.swift
//  AdCampaign
//
//  Created by Vlad Stan on 11.10.2023.
//

import UIKit

class SelectCampaignViewController: UIViewController {
    
    private var viewModel: CampaignSelectionViewModel
    
    @IBOutlet weak var tableView: UITableView?
    @IBOutlet weak var topTitleLabel: UILabel?
    
    init(viewModel: CampaignSelectionViewModel) {
        self.viewModel = viewModel
        super.init(nibName: "\(SelectCampaignViewController.self)", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.title = "Platforms"
        self.tableView?.register(CampaignTableViewCell.self,
                                 forCellReuseIdentifier: "\(CampaignTableViewCell.self)")
        self.topTitleLabel?.text = self.viewModel.dataSourceDescription()
    }
}

extension SelectCampaignViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.availablePlatforms().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let tableViewCell = tableView.dequeueReusableCell(withIdentifier: "\(CampaignTableViewCell.self)", 
                                                                for: indexPath) as? CampaignTableViewCell
        else {
            return UITableViewCell(frame: .zero)
        }
        let platform = self.viewModel.availablePlatforms()[indexPath.row]
        tableViewCell.accessoryType = .disclosureIndicator
        tableViewCell.configure(targetType: platform)
        return tableViewCell
    }
}

extension SelectCampaignViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedItem = self.viewModel.availablePlatforms()[indexPath.row]
        
        guard let dataURL = Bundle.main.url(forResource: "Campaigns", withExtension: "plist") else {
            print("Error - Cannot load campaigns")
            return
        }
        let dataProvider = DataProvider(dataURL: dataURL)
        let viewModel = CampaignDetailsViewModel(dataProvider: dataProvider)
        viewModel.selectedCampaign = selectedItem
        let nextVC = CampaignDetailsViewController(viewModel: viewModel)
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
}
