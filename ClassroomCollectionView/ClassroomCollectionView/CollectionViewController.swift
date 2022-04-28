//
//  CollectionViewController.swift
//  ClassroomCollectionView
//
//  Created by Macbook Air on 28.04.2022.
//

import UIKit

struct Student{
    var name : String
    var studentNumber : Int
}

class CollectionViewController: UICollectionViewController {
    
    var students : [Student] = [Student]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout{
            let rowPerElements : CGFloat = 3
            let space : CGFloat = 3
            let allSpace = space * (rowPerElements - 1)
            let itemSpace = allSpace / rowPerElements
            let width = collectionView.frame.width / rowPerElements - itemSpace
            let height = width
            layout.itemSize = CGSize(width: width, height: height)
            layout.minimumInteritemSpacing = space
            layout.minimumLineSpacing = space
        }

        let student1 = Student(name: "Ali", studentNumber: 1)
        let student2 = Student(name: "Veli", studentNumber: 2)
        let student3 = Student(name: "Kaan", studentNumber: 3)
        let student4 = Student(name: "Melik", studentNumber: 4)
        let student5 = Student(name: "Ayşe", studentNumber: 5)
        let student6 = Student(name: "Ezgi", studentNumber: 6)
        let student7 = Student(name: "Fatih", studentNumber: 7)
        let student8 = Student(name: "Enes", studentNumber: 8)
        let student9 = Student(name: "Akın", studentNumber: 9)
        let student10 = Student(name: "Samet", studentNumber: 10)
        let student11 = Student(name: "Gülşah", studentNumber: 11)
        let student12 = Student(name: "Merve", studentNumber: 12)
        let student13 = Student(name: "Halil", studentNumber: 13)
        let student14 = Student(name: "Sıla", studentNumber: 14)
        let student15 = Student(name: "Cem", studentNumber: 15)
        
        students.append(student1)
        students.append(student2)
        students.append(student3)
        students.append(student4)
        students.append(student5)
        students.append(student6)
        students.append(student7)
        students.append(student8)
        students.append(student9)
        students.append(student10)
        students.append(student11)
        students.append(student12)
        students.append(student13)
        students.append(student14)
        students.append(student15)
        
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return students.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellName", for: indexPath)
        let incomingData = students[indexPath.item]
        
        if let customCell = cell as? CollectionViewCell{
            customCell.labelStudentName.text = incomingData.name
        }
        
        return cell
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "toDetail", sender: indexPath.item)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let index = sender as? Int
        if segue.identifier == "toDetail" {
            let goingVC = segue.destination as! ViewController
            goingVC.student = students[index!]
        }
    }



}
