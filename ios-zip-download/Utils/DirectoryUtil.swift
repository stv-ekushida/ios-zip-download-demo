//
//  DirectoryUtil.swift
//  ios-zip-download
//
//  Created by Eiji Kushida on 2017/01/06.
//  Copyright © 2017年 Eiji Kushida. All rights reserved.
//

import UIKit

final class DirectoryUtil: NSObject {

    func applicationDocumentsDirectory() -> String {

        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory,
                                                        .userDomainMask, true)
        let basePath = paths.count > 0 ? paths.first : nil
        return basePath ?? ""
    }

    func saveZipPath() -> String {
        return applicationDocumentsDirectory() + "/" + "Zips"
    }

    func saveAppPath() -> String {
        return applicationDocumentsDirectory() + "/" + "Apps"
    }

    func moveTempToDocument(destinationPath: String,
                                    location: URL,
                                    docsDirURL: URL) {

        createDirectory(destinationPath: destinationPath)
        removeItem(destinationPath: destinationPath, docsDirURL: docsDirURL)
        moveItem(location: location, docsDirURL: docsDirURL)
    }

    private func createDirectory(destinationPath: String) {

        do {
            try FileManager.default.createDirectory(atPath: destinationPath,
                                                    withIntermediateDirectories: true,
                                                    attributes: nil)

        } catch let error as NSError {
            fatalError(error.localizedDescription)
        }
    }

    private func removeItem(destinationPath: String,
                            docsDirURL: URL) {

        do {
            if FileManager.default.fileExists(atPath: destinationPath) {
                try FileManager.default.removeItem(at: docsDirURL)
            }
        } catch let error as NSError {
            fatalError(error.localizedDescription)
        }
    }

    private func moveItem( location: URL,
                           docsDirURL: URL) {
        do {
            try FileManager.default.moveItem(at: location, to: docsDirURL)
        } catch let error as NSError {
            fatalError(error.localizedDescription)
        }
    }
}
