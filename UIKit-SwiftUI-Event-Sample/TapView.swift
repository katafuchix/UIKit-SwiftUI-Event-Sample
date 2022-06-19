//
//  TapView.swift
//  UIKit-SwiftUI-Event-Sample
//
//  Created by cano on 2022/06/16.
//

import SwiftUI

extension NSNotification.Name {
    static let tapViewTapped = NSNotification.Name("tapViewTapped")
}

struct TapView: View {
    
    @EnvironmentObject var eventMessenger: EventMessenger
    
    private var handler: () -> ()
    
    internal init(handler: @escaping () -> ()) {
        self.handler = handler
    }
    
    var body: some View {
        VStack {
            /*
            Text("This is a SwiftUI Control.")
            Button("Tap Me") {
                //notifier.tapCount += 1
                NotificationCenter.default.post(name: .tapViewTapped, object: nil)
            }*/
            Text("This is a SwiftUI Control.\nTotal taps from UIKit are \(eventMessenger.tapCount) times")
            Button("Tap Me") {
                NotificationCenter.default.post(name: .tapViewTapped, object: nil)
            }
            .buttonStyle(.borderedProminent)
        }
        .padding()
        .background(Color.gray.opacity(0.3))
        .cornerRadius(8)
    }
}

struct TapView_Previews: PreviewProvider {
    static var previews: some View {
        TapView(handler: {})
    }
}
