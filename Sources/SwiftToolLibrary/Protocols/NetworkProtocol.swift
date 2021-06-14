//
//  File.swift
//  
//
//  Created by CC Z on 2021/5/19.
//

import Foundation

public enum NetworkMethodEnum: String {
    case get = "GET", post = "POST", delete = "DELETE"
}

public protocol NetworkProtocol {
    /// eg. https://127.0.0.1/
    var httpPrefix: String { get }
    var timeout: TimeInterval { get }
    
    /// eg. user/login
    var path: String { get }
    var body: [String: Any]? { get }
    var header: [String: String]? { get }
    var method: NetworkMethodEnum { get }
}

public extension NetworkProtocol {
        
    var request: URLRequest {
        var baseUrl = self.httpPrefix + self.path
        guard let url = URL(string: baseUrl) else {
            fatalError("path can not be a URL")
        }
        var request: URLRequest
        let body = self.body
        let method = self.method
        switch method {
        case .get:
            if let body = body {
                let deal = body.compactMap({ "\($0.key)=\($0.value)" }).joined(separator: "&")
                baseUrl += baseUrl.hasSuffix("?") ? "&\(deal)" : "?\(deal)"
                guard let newUrl = URL(string: baseUrl) else {
                    fatalError("path can not be a URL")
                }
                request = self._createURLRequest(newUrl)
            } else {
                request = self._createURLRequest(url)
            }
        case .post, .delete:
            request = self._createURLRequest(url)
            if let body = body {
                request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: .prettyPrinted)
            }
        }
        request.httpMethod = method.rawValue
        for (k, v) in self.header ?? [:] {
            request.addValue(v, forHTTPHeaderField: k)
        }
        return request
    }
}

public extension NetworkProtocol {
    
    func dataTask(_ closure: @escaping (Data?, URLResponse?, Error?)->Void) {
        DispatchQueue.global().async {
            URLSession.shared.dataTask(with: self.request, completionHandler: closure).resume()
        }
    }
}

private extension NetworkProtocol {
    func _createURLRequest(_ url: URL) -> URLRequest {
        URLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: self.timeout)
    }
}
