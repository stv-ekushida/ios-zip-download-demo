//
//  UnzipUtil.swift
//  ios-zip-download
//
//  Created by Eiji Kushida on 2017/01/06.
//  Copyright © 2017年 Eiji Kushida. All rights reserved.
//

import UIKit
import SSZipArchive

protocol UnZipDelegate {
    func didUnZipFile(unzippedPath: String)
}

final class UnzipUtil: NSObject {

    var delegate: UnZipDelegate?

    //TODO : パスワード
    let pwd = "sdt"

    func unzip(destinationPath: String, fileName: String) {

        SSZipArchive.unzipFile(atPath: destinationPath + "/\(fileName)",
            toDestination: DirectoryUtil().saveAppPath(),
            overwrite: true,
            password: pwd,
            progressHandler: { (entry, zipInfo, entryNumber, total) in

        }, completionHandler: { [weak self] (path, succeeded, error) in

            self?.delegate?.didUnZipFile(unzippedPath: path)
        })
    }
}
