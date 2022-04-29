//
//  ViewController.swift
//  BrandsAppTableView
//
//  Created by Macbook Air on 29.04.2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addButton: UIBarButtonItem!
    
    var fileURL : URL!
    
    var markalar : [String] = []
    var counter : Int = 0
    var selectedRow : Int = -1
    
    var brandDescription : [String] = []
    
    var markaAciklamasi : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        tableView.dataSource = self
        tableView.delegate = self
        
        
        // PROGRAMMATIC UI LEFT BAR BUTTON
        let addButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.add, target: self, action: #selector(addButtonClicked))
        addButton.tintColor = UIColor.black
        self.navigationItem.leftBarButtonItem = addButton
        
        // PROGRAMMATIC UI EDIT BUTTON
        let editButton = editButtonItem
        editButton.tintColor = UIColor.systemOrange
        self.navigationItem.leftBarButtonItems?.append(editButton) //items ile dizi şeklinde, soldaki addButton'un yanına ekledi
        
        let baseURL = try! FileManager.default.url(for: FileManager.SearchPathDirectory.documentDirectory, in: FileManager.SearchPathDomainMask.userDomainMask, appropriateFor: nil, create: false)
        print(baseURL)
        
        //fileURL = baseURL.appendingPathComponent("brands.txt")
        //UserDefaults.standard.removeObject(forKey: "brands") //UserDefault'ta yer alan verileri siler.
        loadData()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // ekran her önümüze geldiğinde birşeylerin olmasını istiyorsak burada yapmalıyız.
        
        if selectedRow == -1 {
            return
        }
        
        if markaAciklamasi == ""{
            brandDescription.remove(at: selectedRow)
            markalar.remove(at: selectedRow)
        } else if markaAciklamasi == brandDescription[selectedRow]{
            return
        } else {
            brandDescription[selectedRow] = markaAciklamasi
        }
        saveData()
        tableView.reloadData()
    }

    @IBAction func clickedAddButton(_ sender: Any) {
        
        if tableView.isEditing == true{
            return
        }
        
        let alert = UIAlertController(title: "Add Brand", message: "Input the brand", preferredStyle: UIAlertController.Style.alert)
        alert.addTextField { brandText in
            brandText.placeholder = "Brand Name"
        }
        
        let addAction = UIAlertAction(title: "Add", style: UIAlertAction.Style.default) { action in
            let firstTextField = alert.textFields![0] as UITextField
            self.addBrand(brandName: firstTextField.text!)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil)
        alert.addAction(addAction)
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)
        
    }

}


extension ViewController : UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return markalar.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let brands = markalar[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "markaHucre", for: indexPath)
        cell.textLabel?.text = brands
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath){
        if editingStyle == .delete{
            markalar.remove(at: indexPath.row)
            brandDescription.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.left)
        }
        saveData()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Choose: \(markalar[indexPath.row])")
        performSegue(withIdentifier: "goToDescription", sender: indexPath.row)
    }
    
    
    
    
} // delegate & datasource protocols finished

extension ViewController{
    
    func addBrand(brandName : String){
        
        counter += 1
        markalar.insert(brandName, at: 0)
        brandDescription.insert("None", at: 0)
        let indexPath : IndexPath = IndexPath(row: 0, section: 0)
        tableView.insertRows(at: [indexPath], with: UITableView.RowAnimation.left)
        saveData()
        tableView.selectRow(at: indexPath, animated: true, scrollPosition: .none)
        performSegue(withIdentifier: "goToDescription", sender: self)
    }
    
    @objc func addButtonClicked(){// PROGRAMMATIC UI LEFT BAR BUTTON
        
        if tableView.isEditing == true {
            return
        }
        
        let alert = UIAlertController(title: "Add Brand", message: "Input the brand", preferredStyle: UIAlertController.Style.alert)
        alert.addTextField { brandText in
            brandText.placeholder = "Brand Name"
        }
        
        let addAction = UIAlertAction(title: "Add", style: UIAlertAction.Style.default) { action in
            let firstTextField = alert.textFields![0] as UITextField
            self.addBrand(brandName: firstTextField.text!)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil)
        alert.addAction(addAction)
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)
        
    }// PROGRAMMATIC UI LEFT BAR BUTTON
    
    
    override func setEditing(_ editing: Bool, animated: Bool) { //programmatic ui edit button
        super.setEditing(editing, animated: animated)
        tableView.setEditing(editing, animated: animated)
    }
    
    func saveData() {
        
        UserDefaults.standard.set(markalar, forKey: "brands") // user defaultsa kaydetme.
        UserDefaults.standard.set(brandDescription, forKey: "brandDesc")
        
        //string bir dizi var elimizde. bu diziyi dosyaya yazdırmak istiyoruz. kısa yolu ise NSArray. NS -> Next Step. Bu bir kütüphane. Array'in genişletilmiş ve geliştirilmiş hali diyebiliriz.
        /*let datas = NSArray(array: markalar) // NS array tipine gönderdik
        
        do {
            try datas.write(to: fileURL)
        } catch  {
            print("Write error!!!")
        }*/
        
        
        
        
    } // function of save data finished
    
    func loadData() {
        if let loadedData : [String] = UserDefaults.standard.value(forKey: "brands") as? [String] { // user defaults okuma
            markalar = loadedData
        }
        if let descriptions : [String] = UserDefaults.standard.value(forKey: "brandsDesc") as? [String] {
            brandDescription = descriptions
        }
        tableView.reloadData()
        
        /*if let loadedData: [String] = NSArray(contentsOf: fileURL) as? [String]{ // txt işlemi
            markalar = loadedData
            
        }*/
    } // function of load data finished
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        selectedRow = tableView.indexPathForSelectedRow!.row
        if segue.identifier == "goToDescription"{
            let goingVC = segue.destination as! DescriptionViewController
            goingVC.description(description: brandDescription[selectedRow])
            goingVC.masterView = self
        } else {
            return
        }
    }
    
    
    
} // extension of functions finished
