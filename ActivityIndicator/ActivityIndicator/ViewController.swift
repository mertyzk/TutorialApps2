//
//  ViewController.swift
//  ActivityIndicator
//
//  Created by Macbook Air on 28.04.2022.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var progressView: UIProgressView!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var resultLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        progressView.progress = 0
        
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { Timer in
            self.progressView.progress += 0.1
            let value : Float = self.progressView.progress
            if value == 1 {
                self.resultLabel.text = "SUCCESS"
                Timer.invalidate()
                self.activityIndicator.stopAnimating()
            }
        }
        
    }


}

