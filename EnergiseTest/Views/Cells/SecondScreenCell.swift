//
//  SecondScreenCell.swift
//  EnergiseTest
//
//  Created by Evgeniy Zelinskiy on 26.04.2024.
//

import UIKit
import MapKit

protocol SecondScreenCellDelegate {
    func reload(for button: UIButton)
}

enum SecondScreenCellType: Int {
    case map
    case country
    case regionName
    case city
    case zip
    case timezone
    case query
    case reload
}

class SecondScreenCell: UITableViewCell {
    
    @IBOutlet weak var leftLabel: UILabel!
    @IBOutlet weak var rightLabel: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var reloadButton: UIButton!
    
    var delegate: SecondScreenCellDelegate?
    
    class var identifier: String { return String(describing: self) }
    class var nib: UINib { return UINib(nibName: identifier, bundle: nil) }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupUI()
    }
    
    private func setupUI() {
        selectionStyle = .none
        mapView.userTrackingMode = .follow
    }
    
    func fillCellForRowAt(indexPath: IndexPath, model: GeolocationModel) {
        if let cellType = SecondScreenCellType(rawValue: indexPath.row) {
            self.leftLabel.text = nil
            self.rightLabel.text = nil
            self.reloadButton.isHidden = true
            self.mapView.isHidden = true
            switch cellType {
            case .map:
                let location = CLLocation(latitude: model.lat, longitude: model.lon)
                let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude), span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
                self.mapView.setRegion(region, animated: true)
                self.mapView.isHidden = false
            case .country:
                self.leftLabel.text = "CountryCell.Title".localized
                self.rightLabel.text = model.country
            case .regionName:
                self.leftLabel.text = "RegionCell.Title".localized
                self.rightLabel.text = model.regionName
            case .city:
                self.leftLabel.text = "CityCell.Title".localized
                self.rightLabel.text = model.city
            case .zip:
                self.leftLabel.text = "ZipCell.Title".localized
                self.rightLabel.text = model.zip
            case .timezone:
                self.leftLabel.text = "TimezoneCell.Title".localized
                self.rightLabel.text = model.timezone
            case .query:
                self.leftLabel.text = "QueryCell.Title".localized
                self.rightLabel.text = model.query
            case .reload:
                self.leftLabel.text = nil
                self.reloadButton.isHidden = false
                self.reloadButton.setImage(UIImage.init(systemName: "arrow.clockwise.circle.fill"), for: .normal)
                self.reloadButton.setTitle("ReloadCell.Title".localized, for: .normal)
            }
        }
    }
    
    @IBAction func reload(_ sender: UIButton) {
        delegate?.reload(for: sender)
    }
}
