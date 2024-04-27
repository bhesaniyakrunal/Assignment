//
//  HomeFeedViewController.swift
//  Assignment
//
//  Created by MacBook on 4/27/24.
//

import UIKit

class HomeFeedViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!

    private let viewModel = PostsViewModel()
    private var selectedPostDetails: [String: String] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        viewModel.delegate = self
        viewModel.fetchPosts()
    }

    private func setupTableView() {
        self.tableView.register(UINib(nibName: "SocialMediaTableViewCell", bundle: nil), forCellReuseIdentifier: "SocialMediaTableViewCell")
        self.tableView.separatorStyle = .none
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowDetailSegue" {
            if let detailVC = segue.destination as? DetailViewController,
               let selectedPost = sender as? Post {
                let details = PostHeavyComputationService.computeAdditionalDetails(for: selectedPost)
                detailVC.details = details
            }
        }
    }
}

extension HomeFeedViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfPosts()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SocialMediaTableViewCell") as! SocialMediaTableViewCell
        let post = viewModel.post(at: indexPath.row)
        cell.displayData(post: post)
        cell.selectionStyle = .none
        return cell
    }
}

extension HomeFeedViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let post = viewModel.post(at: indexPath.row)
        let postDetails = DetailViewController(nibName: "DetailViewController", bundle: nil)
        let detail = PostHeavyComputationService.computeAdditionalDetails(for: post)
        postDetails.details = detail
        self.navigationController?.pushViewController(postDetails, animated: true)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        if offsetY > contentHeight - scrollView.frame.size.height {
            viewModel.loadMorePosts()
        }
    }
}

extension HomeFeedViewController: PostsViewModelDelegate {
    func didFetchPosts() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }

    func didFailWithError(_ error: Error) {
    }
}
