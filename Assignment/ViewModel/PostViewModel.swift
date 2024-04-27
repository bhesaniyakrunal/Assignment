//
//  PostViewModel.swift
//  SocialTask
//
//  Created by MacBook on 4/27/24.
//

import Foundation

protocol PostsViewModelDelegate: AnyObject {
    func didFetchPosts()
    func didFailWithError(_ error: Error)
}

class PostsViewModel {
    private let postService: PostServiceProtocol
    private var currentPage = 1
    private var isFetching = false
    private var posts: [Post] = []
    weak var delegate: PostsViewModelDelegate?

    init(postService: PostServiceProtocol = PostService()) {
        self.postService = postService
    }

    func fetchPosts() {
        currentPage = 1
        fetchNextPage()
    }

    func loadMorePosts() {
        fetchNextPage()
    }

    private func fetchNextPage() {
        guard !isFetching else { return }
        isFetching = true
        postService.fetchPosts(page: currentPage) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let fetchedPosts):
                self.posts.append(contentsOf: fetchedPosts)
                self.currentPage += 1
                self.delegate?.didFetchPosts()
            case .failure(let error):
                self.delegate?.didFailWithError(error)
            }
            self.isFetching = false 
        }
    }

    func numberOfPosts() -> Int {
        return posts.count
    }

    func post(at index: Int) -> Post {
        return posts[index]
    }
}
