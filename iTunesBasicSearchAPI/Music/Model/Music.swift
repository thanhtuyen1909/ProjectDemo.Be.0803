//
//  Music.swift
//  iTunesBasicSearchAPI
//
//  Created by tuyen.quach on 23/03/2022.
//

import Foundation
import UIKit

class Music {
    
    //
    // MARK: - Constants
    //
    let artist: String
    let index: Int
    let name: String
    let previewURL: URL
    
    //
    // MARK: - Variables And Properties
    //
    var downloaded = false
    
    //
    // MARK: - Initialization
    //
    init(name: String, artist: String, previewURL: URL, index: Int) {
      self.name = name
      self.artist = artist
      self.previewURL = previewURL
      self.index = index
    }
    
}
