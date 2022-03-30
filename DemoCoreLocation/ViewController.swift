//
//  ViewController.swift
//  DemoCoreLocation
//
//  Created by tuyen.quach on 30/03/2022.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {
    
    //MARK: - Properties
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //        let source = """
        //        {"result":{"name":"Tuyen","address":"Ho Chi Minh","age":22}}
        //    """
        //        let a = """
        //        aaaa
        //            aaaaa
        //        aaaaa
        //        """
        //        print(a)
        //
        //        let user = User(name: "Tuyen", address: "Ho Chi Minh", age: 22)
        //
        //        if let data: Data = encodeData(user: user) {
        //            if let userAnother = decodeData(source: data) {
        //                print(userAnother)
        //            }
        //        }
        
        //delegate
        locationManager.delegate = self
        
        //request location permission
        locationManager.requestWhenInUseAuthorization()
    }
    
    func encodeData(user: User) -> Data? {
        
        let dic: [String:Any] = [
            "result": user.dictionary
        ]
        
        guard let data = try? JSONSerialization.data(withJSONObject: dic) else {
            return nil
        }
        
        //        let encoder = JSONEncoder()
        //        guard let data = try? encoder.encode(user) else {
        //            return nil
        //        }
        
        return data
    }
    
    func decodeData(source: Data) -> User? {
        guard let json = try? JSONSerialization.jsonObject(with: source) as? NSDictionary,
              let data = json["result"] as? NSDictionary,
              let name = data["name"] as? String,
              let address = data["address"] as? String,
              let age = data["age"] as? Int
        else {
            return nil
        }
        //        let decoder = JSONDecoder()
        //        let anotherUser = try! decoder.decode(User.self, from: source)
        return User(name: name,
                    address: address,
                    age: age)
    }
    
    func test(_ value: Int) throws -> Int {
        if value % 2 == 0 {
            return value
        }
        let error = NSError(domain: "", code: 1, userInfo: nil)
        throw error
    }
}
//
//struct Result : Decodable {
//    var result : User
//}

struct User : Codable {
    var name: String
    var address: String
    var age: Int
    
    var dictionary: [String: Any] {
        return ["name": name,
                "address": address,
                "age": age]
    }
}

extension ViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        print("location manager authorization status changed")
        
        switch status {
        case .authorizedAlways:
            print("user allow app to get location data when app is active or in background")
            //get corrent location
            locationManager.requestLocation()
            locationManager.startUpdatingLocation()
            
        case .authorizedWhenInUse:
            print("user allow app to get location data only when app is active")
            //get corrent location
            locationManager.requestLocation()
            locationManager.startUpdatingLocation()
            
        case .denied:
            print("user tap 'disallow' on the permission dialog, cant get location data")
            
        case .restricted:
            print("parental control setting disallow location data")
            
        case .notDetermined:
            print("the location permission dialog haven't shown before, user haven't tap allow/disallow")
            
        default:
            print("default")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error: \(error.localizedDescription)")
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            //manager.stopUpdatingLocation()
            print("latitude: \(location.coordinate.latitude), longitude: \(location.coordinate.longitude)")
            
            //get address:
            let geocoder = CLGeocoder()
            geocoder.reverseGeocodeLocation(location) { (placemarks, error) in
                if error != nil {
                    print("Error in reverseGeocodeLocation")
                }
                guard let placemark = placemarks else {
                    return
                }
                
                if placemark.count > 0 {
                    let placemark = placemark[0]
                    let locality = placemark.locality ?? ""
                    let adminstrativeArea = placemark.administrativeArea ?? ""
                    let country = placemark.country ?? ""
                    
                    print("Address: \(locality), \(adminstrativeArea), \(country)")
                }
            }
        }
    }
}
