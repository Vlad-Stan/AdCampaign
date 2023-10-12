//
//  CampaignDetailsViewController.swift
//  AdCampaign
//
//  Created by Vlad Stan on 11.10.2023.
//

import UIKit
import MessageUI

class CampaignDetailsViewController: UIViewController {

    var viewModel: CampaignDetailsViewModel
    
    @IBOutlet var tableView: UITableView?
    
    private var campaignDetails: SocialMediaCampaign?
    
    init(viewModel: CampaignDetailsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: "\(CampaignDetailsViewController.self)", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.title = self.viewModel.selectedCampaign?.rawValue.name
        self.setupTableView()
        self.loadCampaignData()
    }
    
    private func setupTableView() {
        let reuseId = CampaignDetailsTableViewCell.classNamedReuseID()
        let nib = UINib(nibName: "\(CampaignDetailsTableViewCell.self)", bundle:nil)
        self.tableView?.register(nib, forCellReuseIdentifier: reuseId)
        self.tableView?.rowHeight = UITableView.automaticDimension
        self.tableView?.estimatedRowHeight = 50
    }
    
    private func loadCampaignData() {
        self.viewModel.dataDelegate = self
        self.viewModel.updateData()
    }
}

extension CampaignDetailsViewController: DataUpdateDelegate {
    func didUpdateCampaignData() {
        self.tableView?.reloadData()
    }
}

extension CampaignDetailsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let selection = self.viewModel.selectedCampaign,
              let campaignDetails = self.viewModel.campaignDetailsForSelection(type: selection) else {
            print("No campaign details available")
            return 0
        }
        return campaignDetails.availablePricingOptions().count

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let reuseID = CampaignDetailsTableViewCell.classNamedReuseID()
        guard let cell = tableView.dequeueReusableCell(withIdentifier: reuseID,
                                                       for: indexPath) as? CampaignDetailsTableViewCell,
              let selection = self.viewModel.selectedCampaign,
              let campaignDetails = self.viewModel.campaignDetailsForSelection(type: selection)
        else {
            return UITableViewCell(frame: .zero)
        }

        let pricingOption = campaignDetails.availablePricingOptions()[indexPath.row]
        let displayRepresentable = campaignDetails.displayRepresentation(pricingOption: pricingOption)
        cell.configureWith(cellRepresentable: displayRepresentable)

        return cell
    }
}

extension CampaignDetailsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        self.sendEmail()
    }
}

extension CampaignDetailsViewController: MFMailComposeViewControllerDelegate {
    func sendEmail() {
        // Check if the device can send email
        if MFMailComposeViewController.canSendMail() {
            let mailComposeVC = MFMailComposeViewController()
            mailComposeVC.mailComposeDelegate = self
            
            // Set the email subject, recipient, and message body
            mailComposeVC.setSubject("Campaign details")
            mailComposeVC.setToRecipients(["bogus@bogus.com"])
            mailComposeVC.setMessageBody("", isHTML: false)
            
            // Present the email composer view controller
            self.present(mailComposeVC, animated: true, completion: nil)
        } else {
            // The device can't send email, handle this case
            let alert = UIAlertController(title: "Email Not Available", message: "Your device is not configured to send email.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
//    func mailComposeController(_ controller: MFMailComposeViewController, 
//                               didFinishWith result: MFMailComposeResult,
//                               error: Error?) {
//        
//    }
}
