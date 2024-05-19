//
//  SafariView.swift
//  MyOkashi
//
//  Created by 石崎汐音 on 2024/04/27.
//

import SwiftUI

import SafariServices


struct SafariView : UIViewControllerRepresentable{
    let url : URL
    
    func makeUIViewController(context: Context) -> SFSafariViewController {
        return SFSafariViewController(url: url)
    }
    
    func updateUIViewController(_ uiViewController: SFSafariViewController, context: Context) {
        
    }
    
    
    
}




