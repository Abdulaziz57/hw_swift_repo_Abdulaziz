//
//  ShareSheet.swift
//  SimpleBrowser
//
//  Created by Abdulaziz Al Mannai on 11/03/2025.
//

import SwiftUI

struct ShareSheet: UIViewControllerRepresentable {
    var items: [Any]
    
    func makeUIViewController(context: Context) -> UIActivityViewController {
        UIActivityViewController(activityItems: items, applicationActivities: nil)
    }

    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {}
}


