//
//  JSONDownloader.swift
//  WeatherApp-JSON_API
//
//  Created by Macbook Air on 1.05.2022.
//

import Foundation

class JSONDownloader {
    
    let session : URLSession
    
    init(config : URLSessionConfiguration) {
        self.session = URLSession(configuration: config)
    }
    
    convenience init() {
        self.init(config : URLSessionConfiguration.default) // eğer bir config nesnesi yoksa bu defaulu ata
    }
    
    
    typealias JSON = [String : AnyObject]
    typealias JSONDownloaderCompletionHandler = (JSON? , DarkSkyError?) -> Void
    func jsonTask(with request : URLRequest , completionHandler  completion : @escaping JSONDownloaderCompletionHandler ) -> URLSessionDataTask {
        
        
        let task = session.dataTask(with: request) { data, response, error in
            
            
            guard let httpResponse  = response as? HTTPURLResponse else {
                completion(nil, DarkSkyError.RequestError) // herhangi bir veli olmadığı için nil ve hatayı gönderip, return ediyoruz
                return
            }
            
            if httpResponse.statusCode == 200 { // gelen cevabın durumunu kontrol ediyoruz.
                
                if let data = data { // data başarılı bir şekilde alındı mı? bu yüzden if let ile kontrol ediyoruz
                    
                    do {
                        let json = try JSONSerialization.jsonObject(with: data, options: []) as? JSON // JSON [String : AnyObject] olabilirdi fakat typealias olarak belirttik
                        completion(json, nil) // başarılı oluşturduysak artık completion'a json'u gönderiyoruz.
                    } catch {
                        completion(nil,DarkSkyError.JSONParsingError)
                    }
                    
                } else {
                    //data'da sorun varsa veya elde edilemediyse
                    completion(nil, DarkSkyError.invalidData)
                    
                }
                
            } else {
                //hata meydana geldi
                completion(nil, DarkSkyError.ResponseUnsuccesful(statusCode: httpResponse.statusCode))
            }
        }
        return task
        
    }
}
