//
//  ViewController.swift
//  PlayingCard
//
//  Created by Sonali Patel on 5/15/18.
//  Copyright © 2018 Sonali Patel. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var playingCardView: PlayingCardView! {
        didSet {
            let swipe = UISwipeGestureRecognizer(target: self, action: #selector(ViewController.nextCard))
            swipe.direction = [.left, .right]
            playingCardView.addGestureRecognizer(swipe)
            let pinch = UIPinchGestureRecognizer(target: playingCardView, action: #selector(PlayingCardView.adjustFaceCardScale(byHandlingGestureRecognedBy:)))
            playingCardView.addGestureRecognizer(pinch)
        }
    }
    var deck = PlayingCardDeck()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        for _ in 1...10 {
//            if let card = deck.draw() {
//                print("\(card)")
//            }
//        }
        
    }
    
    @objc func nextCard() {
        if let card = deck.draw() {
            playingCardView.rank = card.rank.order
            playingCardView.suit = card.suit.rawValue
        }
        
    }

    @IBAction func flipCard(_ sender: UITapGestureRecognizer) {
        switch sender.state {
        case .ended:
            playingCardView.isFaceUp = !playingCardView.isFaceUp
        default: break
        }
    
    }
}

