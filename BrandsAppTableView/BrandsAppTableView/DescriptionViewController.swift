//
//  DescriptionViewController.swift
//  BrandsAppTableView
//
//  Created by Macbook Air on 29.04.2022.
//

import UIKit

class DescriptionViewController: UIViewController {
    
    @IBOutlet weak var textView: UITextView!
    
    var desc : String?
    
    var masterView : ViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        textView.text = desc
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        // geri butonuyla tekrar ana ekrana döndüğümüzde burası çalışacak
        
        masterView?.markaAciklamasi = textView.text
        
    }
    
    func description(description : String){
        desc = description
        if isViewLoaded{
            textView.text = desc
        }
    }

}
