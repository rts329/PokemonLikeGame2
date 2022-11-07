//
//  ContentView.swift
//  PokemonLikeGame
//
//  Created by Ryan Shaw on 9/28/22.
//

import SwiftUI
import SpriteKit

let centerOfScreen:CGPoint = CGPoint(x:195, y:302)

class GameScene:SKScene {
    private var myMap = SKSpriteNode()
    private var player = SKSpriteNode()
    private var playerWalkingFrames: [SKTexture] = []
    private var moveables = [SKSpriteNode()]
    
    override func sceneDidLoad() {
        func buildMap() {
            myMap = SKSpriteNode(texture: SKTexture(imageNamed: "Map"))
            myMap.position = centerOfScreen
            addChild(myMap)
        }
        buildMap()
        
        func buildPlayer() {
            let playerDown = SpriteSheet(texture: SKTexture(imageNamed: "playerDown"), rows: 1, columns: 4, spacing: 0, margin: 0)
            let playerDown_0 = playerDown.textureForColumn(column: 0, row: 0)!
            player = SKSpriteNode(texture: playerDown_0)
            player.position = centerOfScreen
            addChild(player)
        }
        buildPlayer()
        
        func buildCollisions() {
            for myShape in collisions {
                myShape.fillColor = UIColor.red
                addChild(myShape)
            }
        }
        buildCollisions()
/*
        func buildMoveables() {
            moveables = [myMap]
        }
*/
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        func animatePlayerWalk(direction: String) {
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
            
            var playerAnimation:Array<SKTexture> = []
            if direction == "up" {
                playerAnimation = playerWalkUp
            }
            if direction == "down" {
                playerAnimation = playerWalkDown
            }
            if direction == "left" {
                playerAnimation = playerWalkLeft
            }
            if direction == "right" {
                playerAnimation = playerWalkRight
            }
            player.run(SKAction.repeatForever(SKAction.animate(with: playerAnimation, timePerFrame: 0.25)))
        }
        
        func getMoveDirection(touchLocation: CGPoint) -> String {
            // Player cannot move diagonally. So, determine which is greater,
            // x or y, and move accordingly.
            if (abs(centerOfScreen.x - touchLocation.x) > abs(centerOfScreen.y - touchLocation.y)) {
                if (touchLocation.x > centerOfScreen.x) {
                    return "right"
                }
                else {
                    return "left"
                }
            }
            
            else {
                if (touchLocation.y > centerOfScreen.y) {
                    return "up"
                }
                else {
                    return "down"
                }
            }
        }
        
        func movePlayer(direction: String) {
            var moveAmount = CGVector(dx: 0, dy: 0)
            let playerSpeed = 200.0
            if direction == "left" {
                moveAmount.dx = playerSpeed
            }
            else if direction == "right" {
                moveAmount.dx = -1 * playerSpeed
            }
            else if direction == "down" {
                moveAmount.dy = playerSpeed
            }
            else if direction == "up" {
                moveAmount.dy = -1 * playerSpeed
            }
            print("playerCollisionBox frame", playerCollisionBox.frame)
            for collidingObject in collisions.dropLast() {
                if collidingObject.intersects(player) {
                    myMap.run(SKAction.repeatForever(SKAction.move(by: CGVector(dx: moveAmount.dx * -1, dy: moveAmount.dy * -1), duration: 1)),
                          withKey: "playerMoving")
                    for i in collisions.indices.dropLast() {
                        collisions[i].run(SKAction.repeatForever(SKAction.move(by: CGVector(dx: moveAmount.dx * -1, dy: moveAmount.dy * -1), duration: 1)))
                    }
                }
                else {
                    myMap.run(SKAction.repeatForever(SKAction.move(by: moveAmount, duration: 1)),
                          withKey: "playerMoving")
                    for i in collisions.indices.dropLast() {
                        collisions[i].run(SKAction.repeatForever(SKAction.move(by: moveAmount, duration: 1)))
                    }
                }
            }
        }
        /*
         let nextPosition = CGRect(x: playerCollisionBox.frame.minX + moveAmount.dx, y: playerCollisionBox.frame.minY + moveAmount.dy, width: playerCollisionBox.frame.width, height: playerCollisionBox.frame.height)
         if collidingObject.intersects(SKShapeNode(rect: nextPosition)) {
             collisionDetected = true
         */

        guard let touch = touches.first else {return}
        let location = touch.location(in:self);
        let direction = getMoveDirection(touchLocation: location)
        
        if myMap.action(forKey: "playerMoving") == nil {
                movePlayer(direction: direction)
        }
        animatePlayerWalk(direction: direction)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for _: AnyObject in touches {
            player.removeAllActions()
            myMap.removeAllActions()
            for obj in collisions {
                obj.removeAllActions()
            }
        }
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

