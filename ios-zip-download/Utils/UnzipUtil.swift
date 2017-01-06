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
    let pwd = ""

    func unzip(destinationPath: String, fileName: String) {

        var error: NSError?
        SSZipArchive.unzipFile(atPath: destinationPath + "/\(fileName)",
            toDestination: DirectoryUtil().saveAppPath(),
            overwrite: true,
            password: pwd,
            error: &error,
            delegate: self)
    }
}

//MARK:- SSZipArchiveDelegate
extension UnzipUtil: SSZipArchiveDelegate {

    func zipArchiveDidUnzipArchive(atPath path: String!,
                                   zipInfo: unz_global_info,
                                   unzippedPath: String!) {
        delegate?.didUnZipFile(unzippedPath: unzippedPath)
    }
}
