//
//  FeedObjects.swift
//  WhatTheSport
//
//  Created by Adam Martin on 7/27/21.
//

import Foundation

class Post {
    var postID: String
    var sport: Sport?
    var team: Team?
    var content: String
    var userID: String
    var username: String
    var numLikes: Int
    var numComments: Int
    
    init(postIDVal: String, sportVal: Sport, teamVal: Team?, contentVal: String, userIDVal: String, usernameVal: String, numLikesVal: Int, numCommentsVal: Int) {
        self.postID = postIDVal
        self.sport = sportVal
        self.team = teamVal
        self.content = contentVal
        self.userID = userIDVal
        self.username = usernameVal
        self.numLikes = numLikesVal
        self.numComments = numCommentsVal
    }
}

//class Event: Post {
//
//}
