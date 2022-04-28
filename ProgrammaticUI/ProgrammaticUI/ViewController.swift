//
//  ViewController.swift
//  ProgrammaticUI
//
//  Created by Macbook Air on 28.04.2022.
//

import UIKit

class ViewController: UIViewController {
    
    let switchView = UISwitch(frame: CGRect(x: 60, y: 110, width: 120, height: 120))

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        

        switchView.setOn(true, animated: true)
        switchView.addTarget(self, action: #selector(switchValueChanged(_:)), for: UIControl.Event.valueChanged)
        view.addSubview(switchView)
        
        // create a button
        
        let button = UIButton(frame: CGRect(x: 60, y: 160, width: 110, height: 50))
        button.setTitle("Open / Close", for: .normal)
        button.setTitleColor(UIColor.red, for: .normal)
        button.backgroundColor = UIColor.lightGray
        view.addSubview(button)
        button.addTarget(self, action: #selector(buttonAction(_:)), for: UIControl.Event.touchUpInside)
        
    }
    
    @objc func switchValueChanged(_ sender : UISwitch){
        if sender.isOn{
            print("open")
        } else {
            print("closed")
        }
    }
    
    @objc func buttonAction(_ sender : UIButton){
        switchView.setOn(!switchView.isOn, animated: true)
        switchValueChanged(switchView)
    }


}

