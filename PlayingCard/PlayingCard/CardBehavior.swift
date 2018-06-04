//
//  CardBehavior.swift
//  PlayingCard
//
//  Created by Sonali Patel on 5/23/18.
//  Copyright © 2018 Sonali Patel. All rights reserved.
//

//
//  CardBehavior.swift
//  PlayingCard
//
//  Created by Sonali Patel on 5/23/18.
//  Copyright © 2018 Sonali Patel. All rights reserved.
//

import UIKit

class CardBehavior: UIDynamicBehavior {
    
    lazy var collisionBehavior: UICollisionBehavior  = {
        let behavior = UICollisionBehavior()
        behavior.translatesReferenceBoundsIntoBoundary = true
        return behavior
    }()
    
    lazy var itemBehavior: UIDynamicItemBehavior = {
        let behavior = UIDynamicItemBehavior()
        behavior.allowsRotation = false
        behavior.elasticity = 1.0
        behavior.resistance = 0
        return behavior
    }()
    
    private func push(_ item: UIDynamicItem) {
        let push = UIPushBehavior(items: [item], mode: .instantaneous)
        if let referenceBounds = dynamicAnimator?.referenceView?.bounds {
            let center = CGPoint(x: referenceBounds.midX, y: referenceBounds.midY)
            switch (item.center.x, item.center.y) {
            case let (x,y) where x < center.x && y < center.y:
                push.angle = (CGFloat.pi / 2).randomSign
            case let (x,y) where x > center.x && y < center.y:
                push.angle = CGFloat.pi - (CGFloat.pi / 2).randomSign
            case let (x,y) where x < center.x && y > center.y:
                push.angle = (-CGFloat.pi / 2).randomSign
            case let (x,y) where x > center.x && y > center.y:
                push.angle = CGFloat.pi + (CGFloat.pi / 2).randomSign
            default:
                push.angle = (CGFloat.pi * 2).randomSign
            }
        }
     //   push.angle = (2 * CGFloat.pi).randomSign
        push.magnitude = CGFloat(1.0) + CGFloat(2.0).randomSign
        push.action = { [unowned push, weak self] in
            self?.removeChildBehavior(push)
            
        }
        addChildBehavior(push)
    }
    
    var gravityBehavior: UIGravityBehavior = {
        let behavior = UIGravityBehavior()
        behavior.magnitude = 0
        return behavior
    }()
    
    func addItem(_ item: UIDynamicItem) {
        collisionBehavior.addItem(item)
        itemBehavior.addItem(item)
        gravityBehavior.addItem(item)
        push(item)
    }
    
    func removeItem(_ item: UIDynamicItem) {
        collisionBehavior.removeItem(item)
        itemBehavior.removeItem(item)
        gravityBehavior.removeItem(item)
    }
    
    override init() {
        super.init()
        addChildBehavior(collisionBehavior)
        addChildBehavior(itemBehavior)
        addChildBehavior(gravityBehavior)
    }
    
    convenience init(in animator: UIDynamicAnimator) {
        self.init()
        animator.addBehavior(self)
    }
    
}

