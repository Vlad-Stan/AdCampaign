//
//  FooterView.swift
//  AdCampaign
//
//  Created by Vlad Stan on 10.10.2023.
//

import UIKit

protocol ActionCallback: AnyObject {
    func buttonPressed()
}

class FooterView: UIView {
    
    @IBOutlet var actionButton: UIButton?
    weak var actionButtonDelegate: ActionCallback?

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    func toggleEnabled(isEnabled: Bool) {
        self.actionButton?.isEnabled = isEnabled
    }
    
    @IBAction func buttonPressed(sender: Any) -> Void {
        self.actionButtonDelegate?.buttonPressed()
    }
    
    static func classNamedNibName() -> String {
        return "\(self)"
    }
    
    class func instanceFromNib() -> FooterView {
        let nibName = FooterView.classNamedNibName()
        return UINib(nibName: nibName, bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! FooterView
    }
}
