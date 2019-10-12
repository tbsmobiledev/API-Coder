//
//  WebAPI.swift
//  Strongco
//
//  Created by TBS21 on 5/23/18.
//  Copyright © 2018 Sazzad Iproliya. All rights reserved.
//


import Foundation
import UIKit
import AVFoundation

func getAPIdata(requestType type: String, url apiUrl: String, parameter parameters: NSDictionary, contentType contentTypes: String, isHudShow isHudCall: Bool, withBlocks block: @escaping (_ jsonObject: Data, _ status: Int) -> Void)
{
    let urlString = apiUrl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
    let url = URL(string: urlString!)!
    print("api url:",url)
    
    var urlRequest = URLRequest(url: url)
    
    urlRequest.setValue(headerValue, forHTTPHeaderField: headerKey)
    urlRequest.setValue(langValue, forHTTPHeaderField: langKey)
    urlRequest.setValue(contentTypes, forHTTPHeaderField: "Content-Type")
    
    urlRequest.timeoutInterval = 30
    
    if type == "POST" {
        urlRequest.httpMethod = "POST"
        do{
            urlRequest.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
        } catch {
        }
    }
    else if type == "GET" {
        urlRequest.httpMethod = "GET"
    }
    
    AF.request(urlRequest).responseData { (responseData) in
        switch responseData.result
        {
        case .success:
            if let data = responseData.value {
                block(data, 1)
            }
        case .failure(let error):
            block(Data(), 0)
            print(error.localizedDescription)
        }
    }
}

func dataToJSON(_ data: Data) -> Any? {
    do {
        return try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
    } catch let error {
        print(error)
    }
    
    return nil
}
