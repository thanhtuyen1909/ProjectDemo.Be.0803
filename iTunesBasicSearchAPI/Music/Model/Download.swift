//
//  Download.swift
//  iTunesBasicSearchAPI
//
//  Created by tuyen.quach on 23/03/2022.
//

import Foundation

//
// MARK: - Download
//
class Download {
    //
    // MARK: - Variables And Properties
    //
    var isDownloading = false
    var progress: Float = 0
    var resumeData: Data?
    var task: URLSessionDownloadTask?
    var music: Music
    
    //
    // MARK: - Initialization
    //
    init(music: Music) {
        self.music = music
    }
}
