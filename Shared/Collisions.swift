//
//  Collisions.swift
//  PokemonLikeGame2 (iOS)
//
//  Created by Ryan Shaw on 10/30/22.
//

import SpriteKit
import UIKit

let fence = SKShapeNode(rect: CGRect(x: 160, y: 86, width: 832, height: 64))
let house = SKShapeNode(rect: CGRect(x: 95, y: 368, width: 208, height: 304))
let playerCollisionBox = SKShapeNode(rect: CGRect(x: 163, y: 270, width: 64, height: 64))
let collisions:Array<SKShapeNode> = [fence, playerCollisionBox]

