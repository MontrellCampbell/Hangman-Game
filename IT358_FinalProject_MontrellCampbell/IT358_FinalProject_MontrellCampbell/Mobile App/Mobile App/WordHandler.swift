//
//  WordHandler.swift
//  Mobile App
//
//  Created by user254287 on 5/1/24.
//
import Foundation


func wordAPICall(completion: @escaping (String?, Error?) -> Void) {
    
    let headers = [
        "X-RapidAPI-Key": "f6ca5a9447mshf37aaab837910a5p17877fjsn3ca53a2bdcfd",
        "X-RapidAPI-Host": "random-word-by-api-ninjas.p.rapidapi.com"
    ]
    
    let request = NSMutableURLRequest(url: NSURL(string: "https://random-word-by-api-ninjas.p.rapidapi.com/v1/randomword")! as URL,
                                      cachePolicy: .useProtocolCachePolicy,
                                      timeoutInterval: 10.0)
    request.httpMethod = "GET"
    request.allHTTPHeaderFields = headers
    
    let session = URLSession.shared
    let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
        if let error = error {
            completion(nil, error)
            return
        }
        
        guard let httpResponse = response as? HTTPURLResponse else {
            let error = NSError(domain: "InvalidResponse", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid response from server"])
            completion(nil, error)
            return
        }
        
        if httpResponse.statusCode == 200 {
            if let data = data {
                do {
                    
                    if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                       let word = json["word"] as? String {
                        
                        completion(word, nil)
                    } else {
                        let error = NSError(domain: "InvalidData", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid data format"])
                        completion(nil, error)
                    }
                } catch {
                    completion(nil, error)
                }
            } else {
                let error = NSError(domain: "NoData", code: 0, userInfo: [NSLocalizedDescriptionKey: "No data received from server"])
                completion(nil, error)
            }
        } else {
            let error = NSError(domain: "HTTPError", code: httpResponse.statusCode, userInfo: [NSLocalizedDescriptionKey: "HTTP Error"])
            completion(nil, error)
        }
    })
    
    dataTask.resume()
}





