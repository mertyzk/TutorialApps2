//
//  ViewController.swift
//  ShareTextWithOtherApps
//
//  Created by Macbook Air on 28.04.2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var messageLabel: UILabel!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func shareButton(_ sender: UIButton) {
        let activityViewController = UIActivityViewController(activityItems: [messageLabel.text!], applicationActivities: nil)
        present(activityViewController, animated: true, completion: nil)
    }
    
}

