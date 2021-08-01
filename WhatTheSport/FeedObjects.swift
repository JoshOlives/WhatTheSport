//
//  FeedObjects.swift
//  WhatTheSport
//
//  Created by Adam Martin on 7/27/21.
//

import Foundation

class Post {
    private var sport: Sport?
    private var team: Team?
    private var content: String
    private var userID: String
    
    init(contentVal: String) {
        self.content = contentVal
        self.userID = "testing"
    }
    
    func getSport() -> Sport? {
        return self.sport
    }
    
    func getTeam() -> Team? {
        return self.team
    }
    
    func getContent() -> String {
        return self.content
    }
}

//class Event: Post {
//    
//}
