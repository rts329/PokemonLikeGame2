//
//  ContentView.swift
//  PokemonLikeGame
//
//  Created by Ryan Shaw on 9/28/22.
//

import SwiftUI
import SpriteKit

let centerOfScreen:CGPoint = CGPoint(x:195, y:302)

let myMap:SKSpriteNode = SKSpriteNode(texture: SKTexture(imageNamed: "Map"))

let playerUp = SpriteSheet(texture: SKTexture(imageNamed: "playerUp"), rows: 1, columns: 4, spacing: 0, margin: 0)
    let playerUp_0 = playerUp.textureForColumn(column: 0, row: 0)!
    let playerUp_1 = playerUp.textureForColumn(column: 1, row: 0)!
    let playerUp_2 = playerUp.textureForColumn(column: 2, row: 0)!
    let playerUp_3 = playerUp.textureForColumn(column: 3, row: 0)!
    
    let playerWalkUp = [playerUp_0, playerUp_1, playerUp_2, playerUp_3]

let playerDown = SpriteSheet(texture: SKTexture(imageNamed: "playerDown"), rows: 1, columns: 4, spacing: 0, margin: 0)
    let playerDown_0 = playerDown.textureForColumn(column: 0, row: 0)!
    let playerDown_1 = playerDown.textureForColumn(column: 1, row: 0)!
    let playerDown_2 = playerDown.textureForColumn(column: 2, row: 0)!
    let playerDown_3 = playerDown.textureForColumn(column: 3, row: 0)!

    let playerWalkDown = [playerDown_0, playerDown_1, playerDown_2, playerDown_3]

let playerLeft = SpriteSheet(texture: SKTexture(imageNamed: "playerLeft"), rows: 1, columns: 4, spacing: 0, margin: 0)
    let playerLeft_0 = playerLeft.textureForColumn(column: 0, row: 0)!
    let playerLeft_1 = playerLeft.textureForColumn(column: 1, row: 0)!
    let playerLeft_2 = playerLeft.textureForColumn(column: 2, row: 0)!
    let playerLeft_3 = playerLeft.textureForColumn(column: 3, row: 0)!

    let playerWalkLeft = [playerLeft_0, playerLeft_1, playerLeft_2, playerLeft_3]

let playerRight = SpriteSheet(texture: SKTexture(imageNamed: "playerRight"), rows: 1, columns: 4, spacing: 0, margin: 0)
    let playerRight_0 = playerRight.textureForColumn(column: 0, row: 0)!
    let playerRight_1 = playerRight.textureForColumn(column: 1, row: 0)!
    let playerRight_2 = playerRight.textureForColumn(column: 2, row: 0)!
    let playerRight_3 = playerRight.textureForColumn(column: 3, row: 0)!

    let playerWalkRight = [playerRight_0, playerRight_1, playerRight_2, playerRight_3]

let playerSprite = SKSpriteNode(texture: playerDown_0)


class GameScene:SKScene {
    
    override func sceneDidLoad() {
        
        physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
        
        
        myMap.position = centerOfScreen
        addChild(myMap)
        
        playerSprite.position = centerOfScreen
        addChild(playerSprite)
        
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {return}
        let location = touch.location(in:self);
        var newLocation = CGVector(dx: 0, dy: 0)
        let playerSpeed = CGPoint(x: 100, y: 100)
        var playerAnimation:Array<SKTexture>
        
        // Player cannot move diagonally. So, determine which is greater,
        // x or y, and move accordingly.
        
        if (abs(centerOfScreen.x - location.x) > abs(centerOfScreen.y - location.y)) {
            if (location.x > centerOfScreen.x) {
                newLocation.dx = -1 * playerSpeed.x
                playerAnimation = playerWalkRight
            }
            else {
                newLocation.dx =  playerSpeed.x
                playerAnimation = playerWalkLeft
            }
        }
        
        else {
            if (location.y > centerOfScreen.y) {
                newLocation.dy = -1 * playerSpeed.y
                playerAnimation = playerWalkUp
            }
            else {
                newLocation.dy =  playerSpeed.y
                playerAnimation = playerWalkDown
            }
        }
        
        myMap.run(SKAction.move(by: newLocation, duration: 1))
        playerSprite.run(SKAction.repeat(SKAction.animate(with: playerAnimation, timePerFrame: 0.2), count: 1))

    }
}

struct PokemonLikeGameView: View {
    var scene:SKScene {
        let scene = GameScene();
        scene.scaleMode = .resizeFill;
        return scene;
    }
    var body: some View {
        VStack{
            SpriteView(scene: scene)
            //ControllerView()
        }
    }
}

struct PokemonLikeGameView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonLikeGameView()
            .previewInterfaceOrientation(.portrait)
    }
}

