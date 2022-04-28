//
//  ViewController.swift
//  ProgressBar
//
//  Created by Macbook Air on 28.04.2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var progressBar: UIProgressView!
    
    let maxTime : Float = 10.0
    var currentTime : Float = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func startButton(_ sender: Any) {
        progressBar.setProgress(0, animated: true)
        
        perform(#selector(progressGuncelle), with: nil, afterDelay: 1.0)
        
    }
    
    @objc func progressGuncelle(){
        currentTime += 1
        print("\(currentTime)")
        let value = currentTime / maxTime
        
        if currentTime < maxTime {
            timeLabel.text = "\(Int(currentTime))"
            progressBar.setProgress(value, animated: true)
            perform(#selector(progressGuncelle), with: nil, afterDelay: 1.0)
        } else {
            timeLabel.text = "Finish"
            progressBar.setProgress(1, animated: true)
        }
    }
    
    
    
}

