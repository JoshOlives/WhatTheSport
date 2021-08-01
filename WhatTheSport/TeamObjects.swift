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
    private var name: String
    private var sport: Sport
    
    init(teamName: String, teamSport: Sport) {
        self.name = teamName
        self.sport = teamSport
    }
    
    func getName() -> String {
        return self.name
    }
    
    func getSport() -> Sport {
        return self.sport
    }
}
