//
//  ZipDownloadUtil.swift
//  ios-zip-download
//
//  Created by Eiji Kushida on 2017/01/06.
//  Copyright © 2017年 Eiji Kushida. All rights reserved.
//

import UIKit

protocol ZipDownloadDelegate {
    func didDownloadFile(destinationPath: String, fileName: String)
}

final class ZipDownloadUtil: NSObject {

    var delegate: ZipDownloadDelegate?

    //TODO : URLを設定する
    private let baseURLString = "http://smartdt.sakura.ne.jp/SDTDEV/MangaBank/manga/"
    private var session: URLSession?
    private var downloadTask: URLSessionDownloadTask?

    fileprivate var fileName = ""
    fileprivate let directory = DirectoryUtil()

    func download(fileName: String) {

        let sessionConfiguration = URLSessionConfiguration.background(
            withIdentifier: "backgroudn-zip-download")

        session = URLSession(configuration: sessionConfiguration,
                             delegate: self,
                             delegateQueue: nil)

        self.fileName = fileName

        if let url = URL(string: baseURLString + fileName) {
            downloadTask = session?.downloadTask(with: url)
            downloadTask?.resume()
        }
    }
}

//MARK:- URLSessionDownloadDelegate
extension ZipDownloadUtil: URLSessionDownloadDelegate {

    func urlSession(_ session: URLSession,
                    downloadTask: URLSessionDownloadTask,
                    didFinishDownloadingTo location: URL) {

        let destinationPath = directory.saveZipPath()
        let docsDirURL = NSURL.fileURL(withPath: destinationPath.appendingPathComponent(self.fileName))

        directory.moveTempToDocument(destinationPath: destinationPath,
                           location: location,
                           docsDirURL: docsDirURL)
        delegate?.didDownloadFile(destinationPath: destinationPath,
                                    fileName: self.fileName)
    }
}
