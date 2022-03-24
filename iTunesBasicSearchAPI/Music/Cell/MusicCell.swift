//
//  MusicCell.swift
//  iTunesBasicSearchAPI
//
//  Created by tuyen.quach on 23/03/2022.
//

import UIKit

protocol MusicCellDelegate {
    func cancelTapped(_ cell: MusicCell)
    func downloadTapped(_ cell: MusicCell)
    func pauseTapped(_ cell: MusicCell)
    func resumeTapped(_ cell: MusicCell)
}

class MusicCell: UITableViewCell {
    
    static let identifier = "Cell"
    
    //
    // MARK: - IBOutlets
    //
    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var downloadButton: UIButton!
    @IBOutlet weak var pauseButton: UIButton!
    @IBOutlet weak var progressLabel: UILabel!
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var titleLabel: UILabel!
    
    //
    // MARK: - Variables And Properties
    //
    
    /// Delegate identifies music for this cell, then
    /// passes this to a download service method.
    var delegate: MusicCellDelegate?
    
    //
    // MARK: - IBActions
    //
    @IBAction func cancelTapped(_ sender: AnyObject) {
        delegate?.cancelTapped(self)
    }
    
    @IBAction func downloadTapped(_ sender: AnyObject) {
        delegate?.downloadTapped(self)
    }
    
    @IBAction func pauseOrResumeTapped(_ sender: AnyObject) {
        if(pauseButton.titleLabel?.text == "Pause") {
            delegate?.pauseTapped(self)
        } else {
            delegate?.resumeTapped(self)
        }
    }
    
    //
    // MARK: - Internal Methods
    //
    func configure(music: Music, downloaded: Bool, download: Download?) {
        titleLabel.text = music.name
        artistLabel.text = music.artist
        
        // Show/hide download controls Pause/Resume, Cancel buttons, progress info.
        var showDownloadControls = false
        
        // Non-nil Download object means a download is in progress.
        if let download = download {
          showDownloadControls = true
          
          let title = download.isDownloading ? "Pause" : "Resume"
          pauseButton.setTitle(title, for: .normal)
          
          progressLabel.text = download.isDownloading ? "Downloading..." : "Paused"
        }
        
        pauseButton.isHidden = !showDownloadControls
        cancelButton.isHidden = !showDownloadControls
        
        progressView.isHidden = !showDownloadControls
        progressLabel.isHidden = !showDownloadControls
        
        // If the music is already downloaded, enable cell selection and hide the Download button.
        selectionStyle = downloaded ? UITableViewCell.SelectionStyle.gray : UITableViewCell.SelectionStyle.none
        downloadButton.isHidden = downloaded || showDownloadControls
    }
    
    func updateDisplay(progress: Float, totalSize : String) {
      progressView.progress = progress
      progressLabel.text = String(format: "%.1f%% of %@", progress * 100, totalSize)
    }
    
}
