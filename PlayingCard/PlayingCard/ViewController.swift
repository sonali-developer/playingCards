//
//  ViewController.swift
//  PlayingCard
//
//  Created by Sonali Patel on 5/15/18.
//  Copyright © 2018 Sonali Patel. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var deck = PlayingCardDeck()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        for _ in 1...10 {
            if let card = deck.draw() {
                print("\(card)")
            }
        }
    }

}

