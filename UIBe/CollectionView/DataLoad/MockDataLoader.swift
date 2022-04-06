//
//  MockDataLoader.swift
//  UIBe
//
//  Created by tuyen.quach on 10/03/2022.
//

import Foundation

class MockDataLoader: DataLoader {
    let url = "https://gw-qa.veep.me/api/v1/be-configuration/customer/get_home_sessions_v2"
    
    func loadData(completion: @escaping (DataSession) -> Void) {
        guard let requestUrl = URL(string: url) else { return }
        
        let parameters: [String : Any] = [
            "client_info": [
                "env": "qa",
                "device_type": "1",
                "location": [
                    "longitude": 106.69368464146106,
                    "latitude": 10.782660491413475
                ],
                "locale": "vi",
                "os_version": "12.4",
                "client_id": "EEBUOvQq7RRJBxJm",
                "app_version": "3614",
                "customer_package_name": "xyz.be.customer"
            ],
            "access_token": "9e556a0047b4f1a4f8078641845207b71c8df3c71e3e0383c12f2d906aa7493c"
        ]
        
        var urlRequest = URLRequest(url: requestUrl)
        urlRequest.httpMethod = "POST"
        
        do {
            urlRequest.httpBody = try JSONSerialization.data(withJSONObject: parameters) // pass dictionary to data object and set it as request body
        } catch let error {
            print(error.localizedDescription)
        }
        
        //HTTP Headers
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.addValue("662866274d810db738ce7521fbb6c6f1cd0b61f938c8172f4cc391bf7e34a6f8", forHTTPHeaderField: "access_token")
        
        
        
        let task = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            guard let data = data else {
                return
            }
            do {
                //create json object from data
                guard let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String : Any],
                      let sessions = json["sessions"] as? Array<Dictionary<String, Any>>,
                      let background_image = json["background_image"] as? String,
                      let text_color = json["text_color"] as? String
                else {
                    return
                }
                var arraySessions = [Session]()
                for session in sessions {
                    guard let type = session["type"] as? String,
                          let data = session["data"] as? Array<Dictionary<String, Any>>,
                          let meta_data = session["meta_data"] as? [String : Any]
                    else {
                        return
                    }
                    var arrayHomeServiceSessions = [HomeSessionService]()
                    for homeservicesession in data {
                        guard let title = homeservicesession["title"] as? [String: String],
                              let name = title["vi"],
                              let image = homeservicesession["image"] as? String,
                              let label =  homeservicesession["label"] as? [String : Any]
                        else {
                            return
                        }
                        arrayHomeServiceSessions.append(HomeSessionService(name: name, image: image, label: label))
                    }
                    if ["schedule", "other_service"].contains(type) == false {
                        arraySessions.append(Session(type: type, data: arrayHomeServiceSessions, meta_data: meta_data))
                    }
                }
                
                completion(DataSession(source: arraySessions, background_image: background_image, text_color: text_color))
            }
            catch {
                print(error.localizedDescription)
            }
        }
        task.resume()
    }
}
