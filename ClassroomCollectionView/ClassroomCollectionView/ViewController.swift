//
//  ViewController.swift
//  ClassroomCollectionView
//
//  Created by Macbook Air on 28.04.2022.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var numberLabel: UILabel!
    
    var student : Student?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        

        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let student = student {
            nameLabel.text = student.name
            numberLabel.text = String(student.studentNumber)
        }
    }


}

