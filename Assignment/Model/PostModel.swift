//
//  PostModel.swift
//  SocialTask
//
//  Created by MacBook on 4/27/24.
//

import Foundation

struct Post:Decodable {
    let id: Int
    let userId: Int
    let title: String
    let body: String

}
class PostHeavyComputationService {
    static func computeAdditionalDetails(for post: Post) -> String {
        let startTime = Date()
        
        var heavyResult = ""
        for _ in 0..<10000 {
            heavyResult += "Some heavy computation result "
        }

        let endTime = Date()
        let timeDifference = endTime.timeIntervalSince(startTime)
        
        return "Heavy computation took \(timeDifference) seconds"
    }
}
