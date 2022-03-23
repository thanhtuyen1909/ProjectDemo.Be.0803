//
//  ViewController.swift
//  iTunesBasicSearchAPI
//
//  Created by tuyen.quach on 23/03/2022.
//

import UIKit
import AVKit
import AVFoundation

//
// MARK: - Search View Controller
//
class SearchViewController: UIViewController {
    //
    // MARK: - Constants
    //
    
    /// Get local file path: download task stores tune here; AV player plays it.
    let documentsPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    
    let downloadService = DownloadService()
    let queryService = QueryService()
    
    var arrMusic = [Music]()
    
    //
    // MARK: - Variables And Properties
    //
    lazy var downloadsSession: URLSession = {
      let configuration = URLSessionConfiguration.background(withIdentifier:
                                                              "com.raywenderlich.HalfTunes.bgSession")
      return URLSession(configuration: configuration, delegate: self, delegateQueue: nil)
    }()
    
    lazy var tapRecognizer: UITapGestureRecognizer = {
        var recognizer = UITapGestureRecognizer(target:self, action: #selector(dismissKeyboard))
        return recognizer
    }()
    
    lazy var musicTableView: UITableView = {
        let tv = UITableView()
        
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.delegate = self
        tv.dataSource = self
        tv.register(UINib(nibName: "MusicCell", bundle: nil), forCellReuseIdentifier: MusicCell.identifier)
        
        return tv
    }()
    
    lazy var searchMusic: UISearchBar = {
        let s = UISearchBar()
        
        s.translatesAutoresizingMaskIntoConstraints = false
        s.placeholder = "Nhập từ khóa..."
        s.sizeToFit()
        s.searchBarStyle = .prominent
        
        s.delegate = self
        
        return s
    }()
    
    
    
    @objc func dismissKeyboard() {
        searchMusic.resignFirstResponder()
    }
    
    func localFilePath(for url: URL) -> URL {
        return documentsPath.appendingPathComponent(url.lastPathComponent)
    }
    
    func playDownload(_ music: Music) {
        let playerViewController = AVPlayerViewController()
        present(playerViewController, animated: true, completion: nil)
        
        let url = localFilePath(for: music.previewURL)
        let player = AVPlayer(url: url)
        playerViewController.player = player
        player.play()
    }
    
    func position(for bar: UIBarPositioning) -> UIBarPosition {
        return .topAttached
    }
    
    func reload(_ row: Int) {
        musicTableView.reloadRows(at: [IndexPath(row: row, section: 0)], with: .none)
    }
    
    //
    // MARK: - View Controller
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        setupEmlements()
        
        musicTableView.tableFooterView = UIView()
        downloadService.downloadsSession = downloadsSession
    }
    
    func setupEmlements() {
        view.addSubview(searchMusic)
        searchMusic.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        searchMusic.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        searchMusic.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        
        view.addSubview(musicTableView)
        musicTableView.topAnchor.constraint(equalTo: searchMusic.bottomAnchor).isActive = true
        musicTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        musicTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        musicTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
    }
}


//
// MARK: - Table View Delegate
//
extension SearchViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //When user taps cell, play the local file, if it's downloaded.
        
        let track = arrMusic[indexPath.row]
        
        if track.downloaded {
            playDownload(track)
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 62.0
    }
}

//
// MARK: - Table View Data Source
//
extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrMusic.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: MusicCell = tableView.dequeueReusableCell(withIdentifier: MusicCell.identifier,
                                                            for: indexPath) as! MusicCell
        // Delegate cell button tap events to this view controller.
        cell.delegate = self
        
        let music = arrMusic[indexPath.row]
        // TODO 13
        cell.configure(music: music, downloaded: music.downloaded, download: downloadService.activeDownloads[music.previewURL])
        
        return cell
    }
    
}

//
// MARK: - Search Bar Delegate
//
extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        dismissKeyboard()
        
        guard let searchText = searchBar.text, !searchText.isEmpty else {
            return
        }
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
        queryService.getSearchResults(searchTerm: searchText) { [weak self] results, errorMessage in
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            
            if let results = results {
                self?.arrMusic = results
                self?.musicTableView.reloadData()
                self?.musicTableView.setContentOffset(CGPoint.zero, animated: false)
            }
            
            if !errorMessage.isEmpty {
                print("Search error: " + errorMessage)
            }
        }
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        view.addGestureRecognizer(tapRecognizer)
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        view.removeGestureRecognizer(tapRecognizer)
    }
}


//
// MARK: - Track Cell Delegate
//
extension SearchViewController: MusicCellDelegate {
    func cancelTapped(_ cell: MusicCell) {
        if let indexPath = musicTableView.indexPath(for: cell) {
            let track = arrMusic[indexPath.row]
            downloadService.cancelDownload(track)
            reload(indexPath.row)
        }
    }
    
    func downloadTapped(_ cell: MusicCell) {
        if let indexPath = musicTableView.indexPath(for: cell) {
            let track = arrMusic[indexPath.row]
            downloadService.startDownload(track)
            reload(indexPath.row)
        }
    }
    
    func pauseTapped(_ cell: MusicCell) {
        if let indexPath = musicTableView.indexPath(for: cell) {
            let track = arrMusic[indexPath.row]
            downloadService.pauseDownload(track)
            reload(indexPath.row)
        }
    }
    
    func resumeTapped(_ cell: MusicCell) {
        if let indexPath = musicTableView.indexPath(for: cell) {
            let track = arrMusic[indexPath.row]
            downloadService.resumeDownload(track)
            reload(indexPath.row)
        }
    }
}

//
// MARK: - URL Session Delegate
//
extension SearchViewController: URLSessionDelegate {
    func urlSessionDidFinishEvents(forBackgroundURLSession session: URLSession) {
        DispatchQueue.main.async {
            if let appDelegate = UIApplication.shared.delegate as? AppDelegate,
               let completionHandler = appDelegate.backgroundSessionCompletionHandler {
                appDelegate.backgroundSessionCompletionHandler = nil
                completionHandler()
            }
        }
    }
}

//
// MARK: - URL Session Download Delegate
//
extension SearchViewController: URLSessionDownloadDelegate {
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask,
                    didFinishDownloadingTo location: URL) {
        // 1
        guard let sourceURL = downloadTask.originalRequest?.url else {
            return
        }
        
        let download = downloadService.activeDownloads[sourceURL]
        downloadService.activeDownloads[sourceURL] = nil
        
        // 2
        let destinationURL = localFilePath(for: sourceURL)
        print(destinationURL)
        
        // 3
        let fileManager = FileManager.default
        try? fileManager.removeItem(at: destinationURL)
        
        do {
            try fileManager.copyItem(at: location, to: destinationURL)
            download?.music.downloaded = true
        } catch let error {
            print("Could not copy file to disk: \(error.localizedDescription)")
        }
        
        // 4
        if let index = download?.music.index {
            DispatchQueue.main.async { [weak self] in
                self?.musicTableView.reloadRows(at: [IndexPath(row: index, section: 0)], with: .none)
            }
        }
    }
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64,
                    totalBytesExpectedToWrite: Int64) {
        // 1
        guard let url = downloadTask.originalRequest?.url, let download = downloadService.activeDownloads[url]  else {
            return
        }
        
        // 2
        download.progress = Float(totalBytesWritten) / Float(totalBytesExpectedToWrite)
        // 3
        let totalSize = ByteCountFormatter.string(fromByteCount: totalBytesExpectedToWrite, countStyle: .file)
        
        // 4
        DispatchQueue.main.async {
            if let musicCell = self.musicTableView.cellForRow(at: IndexPath(row: download.music.index,
                                                                       section: 0)) as? MusicCell {
                musicCell.updateDisplay(progress: download.progress, totalSize: totalSize)
            }
        }
    }
}

