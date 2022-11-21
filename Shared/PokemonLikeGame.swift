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
    private var touching = false
    private var colliding = false
    private var touch = UITouch()
    private var disabledMovements: [String] = []
    
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
                //myShape.fillColor = UIColor.red
                addChild(myShape)
            }
        }
        buildCollisions()
    }
    
    override func update(_ currentTime: TimeInterval) {
        guard touching else { return }
        let (colliding, object) = collisionDetected()
        if colliding {
            disabledMovements = getCollidingDirection(collidingObject: object!)
        }
        else {
            disabledMovements = []
        }
        let direction = getMoveDirection(touchLocation: touch.location(in:self))
        if !disabledMovements.contains(direction) {
            if myMap.action(forKey: "playerMoving") == nil {
                movePlayer(direction: direction)
            }
        }
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        touch = touches.first!
        touching = true
        let direction = getMoveDirection(touchLocation: touch.location(in:self))
        animatePlayerWalk(direction: direction)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        touching = false
        disableMovements()
    }
    
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
    
    func collisionDetected() -> (colliding: Bool, collidingObject: SKShapeNode?) {
        for collidingObject in collisions.dropLast() {
            if collidingObject.intersects(player) {
                return (true, collidingObject)
            }
        }
        return (false, nil)
    }
    
    func getCollidingDirection(collidingObject: SKShapeNode) -> [String] {
        var disabledMovements:[String] = []
        
        let leftDistance = collidingObject.frame.origin.x - (player.frame.origin.x + player.frame.width)
        let rightDistance = collidingObject.frame.origin.x + collidingObject.frame.width - player.frame.origin.x
        let topDistance = collidingObject.frame.origin.y - (player.frame.origin.y + player.frame.height)
        let bottomDistance = collidingObject.frame.origin.y + collidingObject.frame.height - player.frame.origin.y
        
        print("leftDistance:\(leftDistance)")
        print("rightDistance:\(rightDistance)")
        print("topDistance:\(topDistance)")
        print("bottomDistance:\(bottomDistance)")
        
         if abs(leftDistance) < 4 { // player is approaching colliding object from the left
            disabledMovements.append("left")
        }
        if abs(rightDistance) < 4 { // player is approaching colliding object from the right
            disabledMovements.append("right")
        }
        if abs(topDistance) < 4 { // player is approaching colliding object from the top
            disabledMovements.append("up")
        }
        if abs(bottomDistance) < 4 {// player is approaching colliding object from the bottom
            disabledMovements.append("down")
        }
        print("disabledMovements: \(disabledMovements)")
        return disabledMovements
        
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
        let playerSpeed = 6.0
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
        myMap.run(SKAction.move(by: moveAmount, duration: 0.01),
                      withKey: "playerMoving")
        for i in collisions.indices.dropLast() {
            collisions[i].run(SKAction.move(by: moveAmount, duration: 0.01))
        }
    }
    
    func disableMovements() {
        player.removeAllActions()
        myMap.removeAllActions()
        for obj in collisions {
            obj.removeAllActions()
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

