//
//  WebService.swift
//  Ndebele
//
//  Created by phi on 02/02/2017.
//  Copyright © 2017 phi161. All rights reserved.
//

import Foundation

final class NdebeleWebService {

    func rates(completion: @escaping ([Rate]) -> Void) {

        let endpoint = "http://localhost/api/rates"

        guard let endpointURL = URL(string: endpoint) else {
            return
        }

        let json = ["includeMultiplier": true]

        do {
            let data = try JSONSerialization.data(withJSONObject: json, options: [])

            var request = URLRequest(url: endpointURL)
            request.httpMethod = "POST"
            request.httpBody = data
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addValue("application/json", forHTTPHeaderField: "Accept")

            let task = URLSession.shared.dataTask(with: request, completionHandler: { data, _, _ in
                var rates: [Rate] = []

                if let data = data,
                    let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]] {
                    for rateJSON in json! {
                        if let rate = Rate(dictionary: rateJSON) {
                            rates.append(rate)
                        }
                    }
                    completion(rates)
                }
            })
            task.resume()

        } catch {
            //
        }
    }
}
