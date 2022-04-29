//
//  pListLoader.swift
//  MasterDetail(SplitView)-ContactsApp
//
//  Created by Macbook Air on 29.04.2022.
//

import Foundation

enum PListError : Error {
    case invalidRezource // dosya bulunamadığında bu hatayı fırlatacak
    case parsingFailure // dosya var fakat bazı sebeplerden dolayı dosyayı import edemiyoruz
}

class PListLoader {
    static func array(fileName : String , extension_ : String) throws -> [[String : String]] {
        
        guard let path = Bundle.main.path(forResource: fileName, ofType: extension_) else { // find the file path
            throw PListError.invalidRezource
        }
        
        guard let data = NSArray(contentsOfFile: path) as? [[String : String]] else { // fetch the data
            throw PListError.parsingFailure
        }
        
        return data
    }
}


// yukarıda oluşturulan array functiondan gelen diziyi teker teker contact sınıfından oluşturulmuş nesnelere dönüştürmemiz gerekiyor.
// ContactsDB.plist'te 26 tane item var. Bunları teker teker newlemek için class oluşturuyoruz.


class ContactSource { // Contact kaynağı
    
    static var contacts : [Contact] { // Contact struct'u tipinden bir dizi
        let data = try! PListLoader.array(fileName: "ContactsDB", extension_: "plist") // bu kod çalışmalı aksi halde hata alacaz.
        return data.compactMap { Contact(data: $0)} // ilk gelen parametreyle başlarız, array haline getirip return edecektir.
        
        // compactMap içinde teker teker bir sözlük geliyor. bu verileri teker teker alıp Contact'in init'ine gönderir.
        // bu init bu verileri alıp newliyor. toplamda ContactsDB.plist içerisinde Item kadar newleme yapıp return edecektir.
        
    }
}
