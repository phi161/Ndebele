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
        URLSession.shared.dataTask(with: URL(string: "http://localhost:4567/pip")!) { data, _, _ in
            var rates: [Rate] = []

            if let data = data,
                let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]] {
                for rate in json! {
                    if let r = Rate(dictionary: rate) {
                        rates.append(r)
                    }
                }
                completion(rates)
            }
        }.resume()
    }
}
