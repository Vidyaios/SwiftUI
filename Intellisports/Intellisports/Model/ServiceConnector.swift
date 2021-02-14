//
//  ServiceConnector.swift
//  IntelliSports
//
//  Created by Sri Vidya Soundarya Vivekanandan on 2021-01-05.
//

import UIKit
import Alamofire

class ServiceConnector: NSObject {
    static var responseDict = NSDictionary()
    static var statusCode: Int?
    class func serviceConnectorGET(callback : @escaping (NSDictionary?, NSString?, Int?) -> ())
    {
        let baseURL = "https://pushchadev.hopto.org/test.json"
        NSLog("baseURL \(baseURL)")
        print(baseURL)
        var request = URLRequest(url: NSURL.init(string: baseURL)! as URL)
        request.httpMethod = "GET"
        request.timeoutInterval = 20
        AF.request(request).responseJSON {
            response in
            print(response)
            statusCode = response.response?.statusCode
            switch (response.result) {
            case .success:
                print(response)
                if let JSON = response.value {
                    responseDict = JSON as! NSDictionary
                    print("responseObject = \(responseDict)")
                    callback(responseDict,nil,statusCode)
                }
                break
            case .failure(let error):
                print(error)
                break
            }
        }
    }
}
