//
//  APIClient.swift
//  ToDoTDDApp
//
//  Created by Zaki on 22.08.2023.
//

import Foundation

protocol URLSessionProtocol {
    func dataTask(with url: URL, completionHandler: @escaping @Sendable (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask
}

extension URLSession: URLSessionProtocol {}

class APIClient {
    lazy var urlSession: URLSessionProtocol = URLSession.shared

    func login(withName: String, password: String, completionHandler: @escaping (String?, Error?) -> Void) {
        guard let url = URL(string: "https://todoapp.com/login") else {
            fatalError()
        }
        urlSession.dataTask(with: url) { data, response, error in
            
        }.resume()
    }
}
