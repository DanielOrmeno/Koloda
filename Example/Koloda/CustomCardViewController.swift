//
//  CustomCardViewController.swift
//  Koloda
//
//  Created by Daniel Ormeño on 22/03/2016.
//  Copyright © 2016 CocoaPods. All rights reserved.
//
import UIKit

class CustomCardViewController: UIViewController {
    
    var label: String?
    @IBOutlet weak var testButton: UIButton!
    
    //- Constructors
    init(lab: String){
        super.init(nibName: nil, bundle: nil)
        self.label = lab
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    //- UIVIewController overrides
    
    override func viewDidLoad() {
        super.viewDidLoad()
        testButton.titleLabel!.text = self.label
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //- Test Event
    @IBAction func TestButtonEvent(sender: AnyObject) {
        print("Eureka!")
    }
}
