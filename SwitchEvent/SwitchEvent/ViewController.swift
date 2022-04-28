//
//  ViewController.swift
//  SwitchEvent
//
//  Created by Macbook Air on 28.04.2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var resultLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func switchValue(_ sender: UISwitch) {
        resultLabel.text = sender.isOn ? "OPEN" : "CLOSED"
    }
    
}

