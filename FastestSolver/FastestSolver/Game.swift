//
//  Game.swift
//  FastestSolver
//
//  Created by Leo Shakhb on 11.08.22.
//

import Foundation

class Game {
    enum Difficulty: Int {
        case easy
        case medium
        case hard
    }

    enum Configuration: Int {
        case plusMinus
        case multiplyDivide
        case all
    }

    enum Answers: Int {
        case variantA
        case variantB
        case variantC
        case variantD
    }

}
