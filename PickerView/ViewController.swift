//
//  ViewController.swift
//  PickerView
//
//  Created by tuyen.quach on 29/03/2022.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var pickerView: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        pickerView.delegate = self
        pickerView.dataSource = self
        
        // Test NSOperationQueue
        // 1. initialize NSOperationQueue instance
        let queue = OperationQueue()
        // 2. initialize NSBlockOperation instance - subClass of NSOperation
        let operation1 = BlockOperation(block: { [weak self] in
            self?.task1()
        })
        
        // 4. add completion block to operation
        operation1.completionBlock = {
            print("Operation 1 completed")
        }
        // 5. add NSOperation to NSOperationQueue
        queue.addOperation(operation1)
        
        let operation2 = BlockOperation(block: { [weak self] in
            self?.task2()
        })
        
        // 6. add dependency: operation 2 depend on operation 1
        //operation2.addDependency(operation1)
        operation2.completionBlock = {
            print("Operation 2 completed")
        }
        
        operation1.queuePriority = .veryHigh
        operation2.queuePriority = .high
        
        queue.addOperation(operation2)
    }
    
    func task1() {
        for i in 1...3{
            print("Task 1-\(i)")
        }
    }
    func task2() {
        for i in 1...3{
            print("Task 2-\(i)")
        }
    }
    
}

extension ViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "test " + String(row)
    }
}

extension ViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 10
    }
    
    
}
