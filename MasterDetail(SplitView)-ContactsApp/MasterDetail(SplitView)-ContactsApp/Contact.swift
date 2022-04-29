//
//  Contact.swift
//  MasterDetail(SplitView)-ContactsApp
//
//  Created by Macbook Air on 29.04.2022.
//

import Foundation
import UIKit

struct Contact {
    
    let firstName : String
    let lastName : String
    let phone : String
    let email  : String
    let street : String
    let city : String
    let state : String
    let zip : String
    let image : UIImage?
    var favorite :  Bool
    
}

extension Contact{
    
    struct Key {
        //pList keylerini tutmak için struct. Key . (nokta) yaptığımızda buradaki property'lere erişebileceğiz.
        static let firstName = "firstName"
        static let lastName = "lastName"
        static let phone = "phoneNumber"
        static let email = "email"
        static let street = "streetAddress"
        static let city = "city"
        static let state = "state"
        static let zip = "zip"
        static let image = "avatarName"
    }
    
    
    init?(data : [String : String]) { // for contact init.
        // optional. ya hiçbirşey döndürmeyecek ya da key : value ilişkisinde bir contact sınıfından yeni bir nesne döndüreceğiz.
        
        guard let firstNameData = data[Key.firstName] ,
              let lastNameData = data[Key.lastName] ,
              let phoneData = data[Key.phone] ,
              let emailData = data[Key.email] ,
              let streetData = data[Key.street] ,
              let cityData = data[Key.city] ,
              let stateData = data[Key.state] ,
              let zipData = data[Key.zip] else { return nil } // bunlar oluşturulabiliyorsa sorun yok fakat oluşturulamıyorsa return nil
        
        
        // oluşturulabiliyorsa guard'dan gelen parametreleri new'lenecek objenin içine atarız;
        firstName = firstNameData
        lastName = lastNameData
        phone = phoneData
        email = emailData
        street = streetData
        city = cityData
        state = stateData
        zip = zipData
        
        
        if let imageData = data[Key.image] { // eğer resim varsa adı gelen resim adı olarak atanacak. yoksa resim yok olarak değerlendirilecek.
            image = UIImage(named: imageData)
        } else {
            image = nil
        }
        favorite = false // favori kullanıcıya kalan bir durum, ister favoriye atar ister atmaz. bu yüzden default değer olarak false verdik.
    
    } // init finished
    
} // extension finished
