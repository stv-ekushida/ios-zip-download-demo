//
//  ViewController.swift
//  ios-zip-download
//
//  Created by Eiji Kushida on 2017/01/06.
//  Copyright © 2017年 Eiji Kushida. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let loader = ZipDownloadUtil()
    let zipper = UnzipUtil()

    override func viewDidLoad() {
        super.viewDidLoad()
        loader.delegate = self
        loader.download(fileName: "manga_low.zip")
        print("*** ダウンロード開始 ***")
    }
}

//MARK:- ZipDownloadDelegate
extension ViewController: ZipDownloadDelegate {

    func didDownloadFile(destinationPath: String, fileName: String) {
        print("*** ダウンロード完了 ***")
        zipper.delegate = self
        zipper.unzip(destinationPath: destinationPath, fileName: fileName)
    }
}

//MARK:- UnZipDelegate
extension ViewController: UnZipDelegate {

    func didUnZipFile(unzippedPath: String) {
        print("*** 解凍完了 ***")
        print(unzippedPath)
    }
}
