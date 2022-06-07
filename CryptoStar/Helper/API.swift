//
//  API.swift
//  CryptoStar
//
//  Created by Nguyen Ty on 29/05/2022.
//

import Foundation
import Network

class API {
    static let shared = API()
    static func request<T: Codable>(dataAPI: APICoin, completion: @escaping (ClosureResultCoin<T>) -> Void) {
        guard let urlString = dataAPI.url, let url = URL(string: urlString) else { return }
        var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false)
        if dataAPI.parameter?.isEmpty == false && dataAPI.method == HTTPMethod.GET {
            urlComponents?.queryItems = dataAPI.parameter?.dictionaryToURLItem()
        }
        var urlRequest = URLRequest(url: urlComponents!.url!)
        urlRequest.allHTTPHeaderFields = dataAPI.header
        urlRequest.httpMethod = HTTPMethod.GET.rawValue
        if dataAPI.method != HTTPMethod.GET {
            let body = dataAPI.parameter
            if let bodyData = try? JSONSerialization.data(withJSONObject: body ?? [:], options: .fragmentsAllowed) {
                urlRequest.httpBody = bodyData
            }
        }
        let dataTask = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            DispatchQueue.main.async {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
               
                if let data = data {
                    if let responseData = try? decoder.decode(T.self, from: data){
                        completion(.success(data: responseData))
                    }
                    else {
                        completion(.disconnected(data: "Data Empty"))
                    }
                    
                } else if let error = error {
                    completion(.failure(error: error))
                } else {
                    completion(.disconnected(data: "disconnected"))
                }
            }
        }

        dataTask.resume()
    }

    static func requestLogo(dataAPI: APICoin, completion: @escaping (ClosureResultLogo) -> Void) {
        let url = URL(string: dataAPI.url!)
        var urlComponents = URLComponents(url: url!, resolvingAgainstBaseURL: false)
        if dataAPI.parameter?.isEmpty == false && dataAPI.method == HTTPMethod.GET {
            urlComponents?.queryItems = dataAPI.parameter?.dictionaryToURLItem()
        }
        var urlRequest = URLRequest(url: urlComponents!.url!)
        urlRequest.allHTTPHeaderFields = dataAPI.header
        urlRequest.httpMethod = "GET"
        let dataTask = URLSession.shared.dataTask(with: urlRequest) { data, _, error in
            DispatchQueue.main.async {
                if let data = data,
                   let json = try? JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed) as? [String: Any] {
                    if let dataJson = json["data"] as? [String: Any],
                       let dataId = dataJson[dataAPI.id] as? [String: Any],
                       let logo = dataId["logo"] {
                        let logoLink = logo as? String ?? ""
                        completion(.success(data: logoLink))
                    } else {
                        print("Data:\(json), URL: \(url?.absoluteString)")
                        completion(.disconnected(data: "data"))
                    }
                } else if let error = error {
                    completion(.failure(error: error))
                } else {
                    print("Data:\(data) , Error: \(error) - URL: \(url?.absoluteString)")
                    completion(.disconnected(data: "disconnect"))
                }
            }
        }

        dataTask.resume()
    }
}

