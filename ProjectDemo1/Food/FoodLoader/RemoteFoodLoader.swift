//
//  RemoteFoodLoader.swift
//  ProjectDemo1
//
//  Created by tuyen.quach on 09/03/2022.
//

import Foundation

class RemoteFoodLoader: FoodLoader {
    func loadFood(completion: @escaping ([GroupFood]) -> Void) {
        calculateDistance()
        formatDateTime()
        let food = [GroupFood]()
        completion(food)
    }
    
    private func calculateDistance() {
        
    }
    
    private func formatDateTime() {
        
    }
}
