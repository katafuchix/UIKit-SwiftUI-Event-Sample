//
//  ViewController.swift
//  UIKit-SwiftUI-Event-Sample
//
//  Created by cano on 2022/06/16.
//

import UIKit
import SwiftUI
import Combine

class ViewController: UIViewController {

    private var notifier: EventMessenger = EventMessenger()
    private var subs: [AnyCancellable] = []
    
    @IBOutlet weak var countLabel: UILabel!
    
    // Add a local tap count property
    private var tapCount: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        self.countLabel.text = "This is a UIKit Control.\nYou tapped from SwiftUI \(self.tapCount) times"
        
        // Our communication bridge
        /*notifier.$tapCount.sink { [weak self] count in
            self?.countLabel.text = "This is a UIKit Control.\nYou tapped \(count) times"
        }
        .store(in: &subs)*/

        // Later, in viewDidLoad
        let tapView: TapView = TapView(){ [weak self] in
            self?.tapCount += 1
            self?.countLabel.text = "This is a UIKit Control.\nYou tapped from SwiftUI \(self?.tapCount ?? 0) times"
        }
        
        // Now, give the object over to the SwiftUI View
        let tapController = UIHostingController(rootView: tapView.environmentObject(notifier))
        // Truncated: Code to add SwiftUI to view
        view.addSubview(tapController.view)
        addChild(tapController)
        tapController.didMove(toParent: self) 
        
        tapController.view.translatesAutoresizingMaskIntoConstraints = false
        tapController.view.heightAnchor.constraint(equalToConstant: 200).isActive = true
        tapController.view.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 16).isActive = true
        tapController.view.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -16).isActive = true
        tapController.view.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        
        NotificationCenter.default.publisher(for: .tapViewTapped).sink { [weak self] tapEvent in
            self?.tapCount += 1
            self?.countLabel.text = "This is a UIKit Control.\nYou tapped from SwiftUI \(self?.tapCount ?? 0) times"
        }
        .store(in: &subs)
    }

    @IBAction func buttonTap(_ sender: Any) {
        self.notifier.tapCount += 1
    }
    
}

