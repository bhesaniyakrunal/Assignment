//
//  APIManager.swift
//SocialTask
//
//  Created by MacBook on 4/27/24.
//


import Foundation

protocol PostServiceProtocol {
    func fetchPosts(page: Int, completion: @escaping (Result<[Post], Error>) -> Void)
}

class PostService: PostServiceProtocol {
    func fetchPosts(page: Int, completion: @escaping (Result<[Post], Error>) -> Void) {
        let url = URL(string: "https://jsonplaceholder.typicode.com/posts?_page=\(page)")!
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = data else {
                completion(.failure(NSError(domain: "Data not found", code: -1, userInfo: nil)))
                return
            }
            do {
                let decodedData = try JSONDecoder().decode([Post].self, from: data)
                completion(.success(decodedData))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
