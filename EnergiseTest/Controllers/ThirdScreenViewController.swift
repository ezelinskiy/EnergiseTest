//
//  ThirdScreenViewController.swift
//  EnergiseTest
//
//  Created by Evgeniy Zelinskiy on 25.04.2024.
//

import UIKit

class ThirdScreenViewController: UITableViewController {
    
    @IBOutlet weak var rateAppButton: UIButton!
    @IBOutlet weak var shareAppButton: UIButton!
    @IBOutlet weak var contactUsButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        localize()
    }
    
    //MARK: - Localize
    private func localize() {
        title = "ThirdScreen.Title".localized
        
        rateAppButton.setTitle("RateApp.Title".localized, for: .normal)
        shareAppButton.setTitle("ShareApp.Title".localized, for: .normal)
        contactUsButton.setTitle("ContactUs.Title".localized, for: .normal)
    }
    
    //MARK: - Actions
    @IBAction func rateApp(_ sender: UIButton) {
        AppHelper.rateApp()
    }
    
    @IBAction func shareApp(_ sender: UIButton) {
        guard let activityItem = NSURL(string: Constants.contactUsUrlString) else { return }
        
        let activityViewController : UIActivityViewController = UIActivityViewController(activityItems: [activityItem], applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = sender
        activityViewController.popoverPresentationController?.permittedArrowDirections = .any
        activityViewController.popoverPresentationController?.sourceRect = sender.frame
        activityViewController.isModalInPresentation = true
        self.present(activityViewController, animated: true, completion: nil)
    }
    
    @IBAction func contactUs(_ sender: UIButton) {
        AppHelper.openUrl(fromString: Constants.contactUsUrlString)
    }
    
}

//MARK: - ThirdScreenViewControllerExtension
extension ThirdScreenViewController {
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        0.01
    }
}
