//
//  TeamObjects.swift
//  WhatTheSport
//
//  Created by Adam Martin on 7/27/21.
//

import Foundation


enum Sport {
    case basketball, football, baseball
}


class Team {
    var name: String
    var sport: Sport
    var imageID: String
    
    init(_ teamName: String, _ teamSport: Sport, _ teamImageID: String) {
        self.name = teamName
        self.sport = teamSport
        self.imageID = teamImageID
    }
}

let teamsList: [Team] = [Team("Phoenix Suns", Sport.basketball, "sunsLogo"), Team("Denver Nuggets", Sport.basketball, "nuggetsLogo"), Team("Los Angeles Lakers", Sport.basketball, "lakersLogo")]

let sportsList: [Sport] = [Sport.basketball, Sport.football, Sport.baseball]
