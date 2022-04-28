//
//  ViewController.swift
//  UseOfSliders
//
//  Created by Macbook Air on 28.04.2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var headAllLabel: UILabel!
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var sliderOutlet: UISlider!
    
    
    enum Filter : Float {
        case money = 0.0
        case all = 5.0
        case gold = 10.0
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func changedSlider(_ sender: UISlider) {
        
        let fixed = roundf(sender.value / 5.0) * 5.0
        sender.setValue(fixed, animated: true)
        filter()
        
        /*if sender.value < 5 {
            headAllLabel.text = "Money"
            imageView.image = UIImage(named: "para.jpg")
        } else if sender.value > 5 {
            headAllLabel.text = "Gold"
            imageView.image = UIImage(named: "altin.jpg")
        } else if sender.value == 5 {
            headAllLabel.text = "All"
            imageView.image = UIImage(named: "altinvepara.jpg")
        }*/
        
        
    }
    
    func changeImage(named : String) {
        guard let image = UIImage(named: named) else {
            imageView.image = nil
            return
        }
        
        imageView.image = image
    }
    
    func filter() {
        guard let mode = Filter(rawValue: sliderOutlet.value) else {
            headAllLabel.text = "All"
            changeImage(named: "altinvepara.jpg")
            return
        }
        
        switch mode {
        case .money:
            headAllLabel.text = "Money"
            imageView.image = UIImage(named: "para.jpg")
        case .all:
            headAllLabel.text = "All"
            imageView.image = UIImage(named: "altinvepara.jpg")
        case .gold:
            headAllLabel.text = "Gold"
            imageView.image = UIImage(named: "altin.jpg")

        }
    }
    
    
}

