//
//  ViewController.swift
//  SingletonExample
//
//  Created by tuyen.quach on 24/03/2022.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
//        let user = SingletonClass.shared.requestForUser()
//        print("\(user.fname)" + " " + "\(user.lname)")
        
        let dispatchQueueA = DispatchQueue(label: "A", attributes: .concurrent)

        dispatchQueueA.sync { // Task1
            for index in 0 ..< 5 {
                sleep(1)
                print("Task 1 - sync \(index)")
            }
        }

        dispatchQueueA.async(flags: .barrier) { // Task2
            for index in 0 ..< 5 {
                sleep(1)
                print("Task 2 - async with barrier \(index)")
            }
        }

        dispatchQueueA.async { // Task3
            for index in 0 ..< 5 {
                sleep(1)
                print("Task 3 - async without barrier \(index)")
            }
        }

//        dispatchQueueA.async { // Task4
//            for index in 5 ..< 10 {
//                sleep(1)
//                print("Task 4 - async \(index)")
//            }
//        }
//
//        dispatchQueueA.sync { // Task5
//            for index in 5 ..< 10 {
//                sleep(1)
//                print("Task 5 - sync without barrier \(index)")
//            }
//        }
    }


}

