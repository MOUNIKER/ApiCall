//
//  albumManager.swift
//  ApiCall
//
//  Created by Narasimha on 24/07/23.
//

import Foundation

class AlbumManager {

    public func getAlbums(
        completion: @escaping (Result<[Albums], Error>) -> ()
    )  {
        let url = URL(string: "https://jsonplaceholder.typicode.com/albums")!
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { data, _,error in
            if let data = data {
                /// do exception handler so that our app does not crash
                do {
                    let result = try JSONDecoder().decode([Albums].self, from: data)
                    completion(.success(result))
                } catch {
                    print(error.localizedDescription)
                    completion(.failure(error))
                }
            }
        }
        task.resume()
    }
}
