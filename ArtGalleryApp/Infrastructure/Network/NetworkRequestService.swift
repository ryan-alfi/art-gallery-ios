//
//  NetworkRequestService.swift
//  ArtGalleryApp
//
//  Created by Ari Fajrianda Alfi on 16/09/23.
//

import Foundation
import RxSwift

class NetworkRequestService {
    static let shared: NetworkRequestService = NetworkRequestService()

    enum HTTPMethod: String {
        case get = "GET"
        case post = "POST"
    }

    struct Headers {
        var data: [String: String] = [:]
        mutating func addHeader(key: String, value: String) {
            data[key] = value
        }
    }

    typealias QueryParameters = [URLQueryItem]

    struct RequestBody {
        var data: Data?
        init(json: [String: Any]) {
            data = try? JSONSerialization.data(withJSONObject: json, options: [])
        }
    }

    func executeRequest<T: Decodable>(
        baseURL: String? = nil,
        urlPath: String,
        method: HTTPMethod,
        headers: Headers? = nil,
        queryParams: QueryParameters? = nil,
        body: RequestBody? = nil,
        decodingStrategy: JSONDecoder.KeyDecodingStrategy = .useDefaultKeys,
        onlyNeedResponseStatusCode: Bool = false
    ) -> Observable<T> {
        return Observable.create { observer in
            let baseURL = URL(string: Constant.URL.baseURL)!
            let url = baseURL.appendingPathComponent(urlPath)

            var components = URLComponents(url: url, resolvingAgainstBaseURL: false)
            components?.queryItems = queryParams

            guard let finalURL = components?.url else {
                observer.onError(NSError(domain: "InvalidURL", code: 0, userInfo: nil))
                return Disposables.create()
            }

            var request = URLRequest(url: finalURL)
            request.httpMethod = method.rawValue

            if let headers = headers {
                for (key, value) in headers.data {
                    request.setValue(value, forHTTPHeaderField: key)
                }
            }

            if let requestBody = body {
                request.httpBody = requestBody.data
            }

            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    observer.onError(error)
                    return
                }

                guard let httpResponse = response as? HTTPURLResponse else {
                    observer.onError(NSError(domain: "InvalidResponse", code: 0, userInfo: nil))
                    return
                }

                guard (200...299).contains(httpResponse.statusCode) else {
                    observer.onError(NSError(domain: "HTTPError", code: httpResponse.statusCode, userInfo: nil))
                    return
                }

                do {
                    if onlyNeedResponseStatusCode {
                        observer.onNext("" as! T)
                    } else if let data = data {
                        let decoder = JSONDecoder()
                        decoder.keyDecodingStrategy = decodingStrategy
                        let decodedData = try decoder.decode(T.self, from: data)
                        observer.onNext(decodedData)
                    } else {
                        observer.onError(NSError(domain: "InvalidData", code: 0, userInfo: nil))
                    }
                    observer.onCompleted()
                } catch {
                    observer.onError(error)
                }
            }
            task.resume()

            return Disposables.create {
                task.cancel()
            }
        }
    }
}
