//
//  FeedObjects.swift
//  WhatTheSport
//
//  Created by Adam Martin on 7/27/21.
//

import Foundation

class Post {
    var postID: String
    var sportIndex: Int
    var teamIndex: Int?
    var content: String
    var userID: String
    var username: String
    var numLikes: Int
    var numComments: Int
    var userLikedPost: Bool
    
    init(postIDArg: String, sportIndexArg: Int, teamIndexArg: Int?, contentArg: String, userIDArg: String, usernameArg: String, numLikesArg: Int, numCommentsArg: Int, userLikedPostArg: Bool) {
        self.postID = postIDArg
        self.sportIndex = sportIndexArg
        self.teamIndex = teamIndexArg
        self.content = contentArg
        self.userID = userIDArg
        self.username = usernameArg
        self.numLikes = numLikesArg
        self.numComments = numCommentsArg
        self.userLikedPost = userLikedPostArg
    }
}
