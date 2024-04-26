//
//  GeolocationManager.swift
//  EnergiseTest
//
//  Created by Evgeniy Zelinskiy on 25.04.2024.
//

import Foundation
import Alamofire

class GeolocationManager {
    var model: GeolocationModel?
    
    func fetchData(completion: @escaping (GeolocationModel?) -> Void, onFailure: @escaping () -> Void) {
        let urlString = String(format: Constants.ipApiUrlStringFormat1, AppHelper.currentLocale())
        AF.request(urlString).responseDecodable(of: GeolocationModel.self) { response in
            switch response.result {
            case .success(let dTypes):
                self.model = dTypes
                self.model?.save()
                completion(self.model ?? nil)
            case .failure(let error):
                print(error)
                onFailure()
            }
        }
    }
    
    func saveData() {
        if let model = model {
            
        }
        
    }
}
