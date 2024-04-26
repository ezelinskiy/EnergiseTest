//
//  SecondScreenViewController.swift
//  EnergiseTest
//
//  Created by Evgeniy Zelinskiy on 26.04.2024.
//

import UIKit
import PullToRefresh

class SecondScreenViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var model: GeolocationModel? = nil
    let refresher = PullToRefresh()
    
    //MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        localize()
        requestData()
    }
    
    deinit {
        tableView.removeAllPullToRefresh()
    }
    
    //MARK: - SetupUI
    private func setupUI() {
        refresher.setEnable(isEnabled: true)
        
        tableView.register(SecondScreenCell.nib, forCellReuseIdentifier: SecondScreenCell.identifier)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.addPullToRefresh(refresher) {
            self.requestData()
        }
    }
    
    //MARK: - Localize
    private func localize() {
        title = "SecondScreen.Title".localized
    }
    
    //MARK: - RequestData
    private func requestData() {
        model = GeolocationModel(from: UserDefaults.standard)
        self.tableView.reloadData()
        
        requestData {
            self.tableView.endRefreshing(at: .top)
            self.tableView.reloadData()
        }
    }
    
    private func requestData(completion: @escaping () -> ()) {
        GeolocationManager().fetchData { model in
            if let model = model {
                self.model = model
            }
            completion()
        } onFailure: {
            completion()
        }
    }

}

//MARK: - UITableViewDataSource
extension SecondScreenViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 8
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: SecondScreenCell.identifier)! as? SecondScreenCell, let model = model {
            cell.delegate = self
            cell.fillCellForRowAt(indexPath: indexPath, model: model)
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let cellType = SecondScreenCellType(rawValue: indexPath.row)
        var height = 44.0
        if cellType == .map {
            height = 200.0
        } else if cellType == .reload {
            height = 50.0
        }
        return height
    }
    
}

//MARK: - UITableViewDelegate
extension SecondScreenViewController: UITableViewDelegate {
    
}

//MARK: - SecondScreenCellDelegate
extension SecondScreenViewController: SecondScreenCellDelegate {
    
    func reload(for button: UIButton) {
        requestData()
    }
}
