//
//  MockFoodLoader.swift
//  ProjectDemo1
//
//  Created by tuyen.quach on 09/03/2022.
//

import Foundation

class MockFoodLoader: FoodLoader {
    private let mockData = [
        GroupFood(name: "Trending", food: [
            Food(name: "Good Thai", address: "20 Queen Street, NSW"),
            Food(name: "Sushi Car", address: "20/25/26/27 Queen Street, NSW"),
            Food(name: "Blacksmith Cafe", address: "20/25/26/27 Queen Street, NSW 20/25/26/27 Queen Street, NSW 20/25/26/27 Queen Street, NSW"),
            Food(name: "Pizza Box", address: "20 Queen Street, NSW")
        ]),
        GroupFood(name: "Best sales", food: [
            Food(name: "Good Thai", address: "20 Queen Street, NSW"),
            Food(name: "Sushi Car", address: "20/25/26/27 Queen Street, NSW"),
            Food(name: "Blacksmith Cafe", address: "20/25/26/27 Queen Street, NSW 20/25/26/27 Queen Street, NSW 20/25/26/27 Queen Street, NSW"),
            Food(name: "Pizza Box", address: "20 Queen Street, NSW"),
            Food(name: "KFC", address: "Tran Hung Dao Street, ASA"),
            Food(name: "Pizza HUT", address: "20 Queen Street, KND"),
            
        ])
    ]
    
    func loadFood(completion: @escaping ([GroupFood]) -> Void) {
        completion(mockData)
    }
}
