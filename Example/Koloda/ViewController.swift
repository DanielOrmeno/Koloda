//
//  ViewController.swift
//  Koloda
//
//  Created by Eugene Andreyev on 4/23/15.
//  Copyright (c) 2015 Eugene Andreyev. All rights reserved.
//

import UIKit
import Koloda

private var numberOfCards: UInt = 5

class ViewController: UIViewController {
    
    @IBOutlet weak var kolodaView: KolodaView!
    
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        kolodaView.dataSource = self
        kolodaView.delegate = self
        
        self.modalTransitionStyle = UIModalTransitionStyle.FlipHorizontal
    }
    
    
    //MARK: IBActions
    @IBAction func leftButtonTapped() {
        kolodaView?.swipe(SwipeResultDirection.Left)
    }
    
    @IBAction func rightButtonTapped() {
        kolodaView?.swipe(SwipeResultDirection.Right)
    }
    
    @IBAction func undoButtonTapped() {
        kolodaView?.revertAction()
    }
}

//MARK: KolodaViewDelegate
extension ViewController: KolodaViewDelegate {
    
    func koloda(koloda: KolodaView, didSwipedCardAtIndex index: UInt, inDirection direction: SwipeResultDirection) {
        //Example: loading more cards
        if index >= 3 {
            numberOfCards = 6
            kolodaView.reloadData()
        }
    }
    
    func koloda(kolodaDidRunOutOfCards koloda: KolodaView) {
        //Example: reloading
        kolodaView.resetCurrentCardNumber()
    }
    
    func koloda(koloda: KolodaView, didSelectCardAtIndex index: UInt) {
        print("tap Event Detected")
    }
    
                                                                                            //- HERE I DISABLE THE TAP AND PAN GESTURES FOR THE BUTTON.
    func koloda(koloda: KolodaView, didShowCardAtIndex index: UInt) {
        let subviews = koloda.subviews
        for subview in subviews {
            if let recognizers = subview.gestureRecognizers {
                for gesture in recognizers {
                    if gesture is UIPanGestureRecognizer || gesture is UITapGestureRecognizer{
                        //- Also tried setting this to false but nothing.
                        gesture.cancelsTouchesInView = false
                        gesture.delegate = self
                    }
                }
            }
        }
    }
}

//MARK: KolodaViewDataSource
extension ViewController: KolodaViewDataSource {
    
    func koloda(kolodaNumberOfCards koloda:KolodaView) -> UInt {
        return numberOfCards
    }
    
    func koloda(koloda: KolodaView, viewForCardAtIndex index: UInt) -> UIView {
        let vc = CustomCardViewController(lab: "Test Action")
        return vc.view
    }
    
    func koloda(koloda: KolodaView, viewForCardOverlayAtIndex index: UInt) -> OverlayView? {
        return NSBundle.mainBundle().loadNibNamed("OverlayView",
            owner: self, options: nil)[0] as? OverlayView
    }
}

extension ViewController: UIGestureRecognizerDelegate {
        func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldReceiveTouch touch: UITouch) -> Bool {
            if touch.view is UIButton {
                return false
            } else {
                return true
            }
        }
}

